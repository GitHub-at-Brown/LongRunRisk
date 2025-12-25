#!/usr/bin/env python3
"""
Split .wlt test files into individual single-test files for precise coverage analysis.

This script:
1. Reads all .wlt files from Tests/ directory (recursively)
2. Extracts VerificationTest blocks while preserving structure
3. Creates N split files for each source file with N tests
4. Preserves headers, initialization tests, cleanup tests, and footers
5. Only modifies files in temp-tests-inst/ directory

⚠️ CRITICAL: This script does NOT modify any files in the Tests/ directory tree.
"""

import os
import re
from pathlib import Path
from typing import List, Dict, Tuple
from datetime import datetime


class TestFileSplitter:
    def __init__(self, tests_root: Path, output_dir: Path):
        self.tests_root = tests_root
        self.output_dir = output_dir
        self.stats = {
            'files_processed': 0,
            'tests_extracted': 0,
            'split_files_created': 0,
            'errors': []
        }

    def find_matching_bracket(self, text: str, start_pos: int) -> int:
        """
        Find the matching closing bracket ] for opening bracket [ at start_pos.
        Handles nested brackets correctly.

        Args:
            text: The text to search in
            start_pos: Position of the opening bracket

        Returns:
            Position of the matching closing bracket, or -1 if not found
        """
        if text[start_pos] != '[':
            return -1

        depth = 0
        for i in range(start_pos, len(text)):
            if text[i] == '[':
                depth += 1
            elif text[i] == ']':
                depth -= 1
                if depth == 0:
                    return i
        return -1

    def extract_verification_tests(self, content: str) -> List[Dict]:
        """
        Extract all VerificationTest blocks from content.

        Returns:
            List of dicts with keys: 'content', 'start_pos', 'end_pos', 'type'
        """
        tests = []
        pattern = r'VerificationTest\s*\['

        for match in re.finditer(pattern, content):
            start_pos = match.start()
            bracket_start = match.end() - 1  # Position of '['
            bracket_end = self.find_matching_bracket(content, bracket_start)

            if bracket_end == -1:
                self.stats['errors'].append(f"Unmatched bracket at position {bracket_start}")
                continue

            # Extract the full VerificationTest block
            test_block = content[start_pos:bracket_end + 1]

            # Identify test type
            test_type = self.identify_test_type(test_block)

            tests.append({
                'content': test_block,
                'start_pos': start_pos,
                'end_pos': bracket_end + 1,
                'type': test_type
            })

        return tests

    def identify_test_type(self, test_block: str) -> str:
        """
        Identify whether this is an initialization, actual, or cleanup test.

        Init/cleanup tests are simple VerificationTest blocks that just verify
        setup/teardown succeeded, typically with pattern:
            VerificationTest[<setup code>; True, True, ...]
        or multiline:
            VerificationTest[
                <setup code>;
                True
                ,
                True
            ]

        Returns:
            'init', 'actual', or 'cleanup'
        """
        # Cleanup test: restores $ContextPath and returns True
        # Pattern: VerificationTest[$ContextPath = Select...; True, True, ...]
        if ('$ContextPath = Select' in test_block and
            'Select[$ContextPath' in test_block and
            'Private`' in test_block):
            return 'cleanup'

        # Initialization tests: setup commands followed by True
        # Check for init patterns that indicate this is a setup test
        init_patterns = [
            'Needs @',
            'Needs[',
            'Off[General::',
            'Off[FindRoot::',
        ]

        # Extract first argument to check if it's <command>; True or <command>;\n True
        bracket_start = test_block.find('VerificationTest[')
        if bracket_start != -1:
            bracket_pos = test_block.find('[', bracket_start)
            # Find first comma at depth 1
            depth = 0
            first_comma_pos = -1
            for i in range(bracket_pos, len(test_block)):
                if test_block[i] == '[':
                    depth += 1
                elif test_block[i] == ']':
                    depth -= 1
                elif test_block[i] == ',' and depth == 1:
                    first_comma_pos = i
                    break

            if first_comma_pos != -1:
                first_arg = test_block[bracket_pos + 1:first_comma_pos].strip()

                # Check if first arg matches: <code>; True or <code>;\n True
                lines = first_arg.split('\n')
                # Remove trailing True and whitespace lines
                while lines and lines[-1].strip() in ('True', ''):
                    lines.pop()

                # If after removing True we have code ending in ;, it's likely init/cleanup
                code_without_true = '\n'.join(lines).strip()

                if code_without_true.endswith(';'):
                    # Check if it matches init patterns
                    for pattern in init_patterns:
                        if pattern in code_without_true:
                            return 'init'

                    # Check for longTest definition
                    if 'longTest' in code_without_true and '=' in code_without_true:
                        return 'init'

                    # Check for cleanup pattern
                    if '$ContextPath = Select' in code_without_true and 'Private`' in code_without_true:
                        return 'cleanup'

        # Default to actual test
        return 'actual'

    def extract_code_from_verification_test(self, test_block: str) -> str:
        """
        Extract the actual code from a VerificationTest block.

        For init/cleanup tests like:
            VerificationTest[Needs @ "..."; True, True, ...]
        or:
            VerificationTest[
                Needs @ "...";
                True
                ,
                True
            ]

        Returns just:
            Needs @ "..."

        Args:
            test_block: The full VerificationTest[...] string

        Returns:
            The extracted code without VerificationTest wrapper
        """
        # Find the opening bracket after VerificationTest
        vt_start = test_block.find('VerificationTest')
        if vt_start == -1:
            return test_block.strip()

        bracket_start = test_block.find('[', vt_start)
        if bracket_start == -1:
            return test_block.strip()

        # Find the first comma at bracket depth 1 (separates first arg from second arg)
        depth = 0
        first_comma_pos = -1

        for i in range(bracket_start, len(test_block)):
            if test_block[i] == '[':
                depth += 1
            elif test_block[i] == ']':
                depth -= 1
            elif test_block[i] == ',' and depth == 1:
                first_comma_pos = i
                break

        if first_comma_pos == -1:
            return test_block.strip()

        # Extract the first argument (the actual code)
        code = test_block[bracket_start + 1:first_comma_pos].strip()

        # Remove trailing "; True" or just "True" if present (handling multiline)
        # Split by lines and work backwards to remove standalone "True"
        lines = code.split('\n')

        # Remove trailing lines that are just "True" or whitespace
        while lines and lines[-1].strip() in ('True', ''):
            lines.pop()

        # Rejoin and check for inline "; True" patterns
        code = '\n'.join(lines).strip()

        # Remove " True" suffix while preserving the semicolon
        # Pattern: ]; True -> ];    or    ; True -> ;
        import re
        code = re.sub(r';\s+True\s*$', ';', code).strip()

        return code

    def extract_test_list_wrapper(self, content: str) -> Tuple[str, List[str], int, str]:
        """
        Detect and extract test list wrapper from content.

        Handles two patterns:
        1. tests = With[{f = ToExpression[...]}, { <tests> }];
        2. tests = { <tests> };

        Returns:
            (content, binding_assignments, wrapper_start_pos, wrapper_type)
            where wrapper_type is "with", "bare_list", or "none"
        """
        # Pattern 1: tests = With[{bindings}, {
        with_pattern = r'tests\s*=\s*With\s*\[\s*\{([^}]+)\}\s*,\s*\{\s*'
        with_match = re.search(with_pattern, content, re.DOTALL)

        if with_match:
            # Extract the bindings string
            bindings_str = with_match.group(1).strip()

            # Parse individual bindings (handle nested brackets)
            bindings = []
            current_binding = []
            depth = 0

            for char in bindings_str:
                if char in '[{(':
                    depth += 1
                elif char in ']})':
                    depth -= 1
                elif char == ',' and depth == 0:
                    # End of binding
                    binding = ''.join(current_binding).strip()
                    if binding:
                        bindings.append(binding + ';')
                    current_binding = []
                    continue

                current_binding.append(char)

            # Add last binding
            if current_binding:
                binding = ''.join(current_binding).strip()
                if binding:
                    bindings.append(binding + ';')

            return content, bindings, with_match.start(), "with"

        # Pattern 2: tests = {
        bare_list_pattern = r'tests\s*=\s*\{\s*'
        bare_match = re.search(bare_list_pattern, content, re.DOTALL)

        if bare_match:
            # No bindings for bare list
            return content, [], bare_match.start(), "bare_list"

        return content, [], -1, "none"

    def parse_test_file(self, file_path: Path) -> Dict:
        """
        Parse a .wlt file and extract its components.

        Returns:
            Dict with keys: 'header', 'init_tests', 'actual_tests', 'cleanup_test', 'footer', 'with_bindings'
        """
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Extract test list wrapper (With block or bare list)
        content_for_parsing, bindings, wrapper_start_pos, wrapper_type = self.extract_test_list_wrapper(content)

        # Extract all VerificationTest blocks
        tests = self.extract_verification_tests(content_for_parsing)

        # Categorize tests
        init_tests = [t for t in tests if t['type'] == 'init']
        actual_tests = [t for t in tests if t['type'] == 'actual']
        cleanup_tests = [t for t in tests if t['type'] == 'cleanup']

        # Extract inter-test code (bare code between tests) - but skip if we have a wrapper
        if wrapper_type == "none":
            inter_test_code = self.extract_inter_test_code(content_for_parsing, tests)
        else:
            inter_test_code = {}

        # Verify we have the expected structure
        if len(cleanup_tests) > 1:
            self.stats['errors'].append(f"{file_path.name}: Multiple cleanup tests found")

        cleanup_test = cleanup_tests[0] if cleanup_tests else None

        # Determine header end position
        if wrapper_start_pos != -1:
            # Header ends BEFORE "tests = ..." wrapper
            header_end = wrapper_start_pos
        elif tests:
            # Header ends before first test
            header_end = tests[0]['start_pos']
        else:
            header_end = len(content_for_parsing)

        header = content_for_parsing[:header_end].rstrip()

        # Determine footer start position (after last test)
        if cleanup_test:
            footer_start = cleanup_test['end_pos']
        elif actual_tests:
            footer_start = actual_tests[-1]['end_pos']
        elif init_tests:
            footer_start = init_tests[-1]['end_pos']
        else:
            footer_start = header_end

        footer = content_for_parsing[footer_start:].lstrip()

        # Clean up footer based on wrapper type
        if wrapper_type == "with":
            # Remove "}];" for With blocks
            footer = re.sub(r'^\s*\}\s*\]\s*;\s*', '', footer)
        elif wrapper_type == "bare_list":
            # Remove "};" for bare list
            footer = re.sub(r'^\s*\}\s*;\s*', '', footer)

        return {
            'header': header,
            'init_tests': init_tests,
            'actual_tests': actual_tests,
            'cleanup_test': cleanup_test,
            'footer': footer,
            'inter_test_code': inter_test_code,
            'with_bindings': bindings,
            'has_wrapper': wrapper_type != "none",
            'wrapper_type': wrapper_type,
            'original_content': content
        }

    def extract_state_setup_from_test(self, test_block: str) -> str:
        """
        Extract state setup code from a test that sets up shared state.

        Tests that set up state have pattern:
            VerificationTest[
                var1 = ...;
                var2 = ...;
                Apply[And, { ... actual test logic ... }]
                ,
                True
            ]

        We extract the variable assignments (var1 = ...; var2 = ...;)
        by finding all complete statements (ending with ;) before the test logic.
        """
        # Extract first argument
        bracket_start = test_block.find('VerificationTest[')
        if bracket_start == -1:
            return ''

        bracket_pos = test_block.find('[', bracket_start)
        depth = 1  # Start at 1 because we're already inside VerificationTest[
        first_comma_pos = -1

        for i in range(bracket_pos + 1, len(test_block)):  # Start after the opening [
            if test_block[i] in '[{(':
                depth += 1
            elif test_block[i] in ']})':
                depth -= 1
            elif test_block[i] == ',' and depth == 1:
                first_comma_pos = i
                break

        if first_comma_pos == -1:
            return ''

        first_arg = test_block[bracket_pos + 1:first_comma_pos].strip()

        # Split by semicolons to find complete statements
        # But be careful not to split on semicolons inside brackets
        statements = []
        current_statement = []
        bracket_depth = 0

        for char in first_arg:
            if char in '[{(':
                bracket_depth += 1
            elif char in ']})':
                bracket_depth -= 1
            elif char == ';' and bracket_depth == 0:
                # End of statement
                stmt = ''.join(current_statement).strip()
                if stmt:
                    statements.append(stmt)
                current_statement = []
                continue

            current_statement.append(char)

        # Check if there's a remaining statement
        remaining = ''.join(current_statement).strip()

        # Filter statements: keep only assignments and function definitions, stop at test logic
        setup_statements = []
        for stmt in statements:
            stripped = stmt.strip()
            # Stop when we hit test logic
            if any(stripped.startswith(kw) for kw in ['Apply[', 'SameQ[', 'FreeQ[', '!SameQ[', '!FreeQ[', 'Not[', 'And[', 'Or[']):
                break
            # Include if it's:
            # 1. An assignment or function definition (contains = or :=)
            # 2. SetAttributes statement (often precedes function definitions)
            # 3. Other definition-related statements
            if ('=' in stripped and not any(stripped.startswith(op) for op in ['==', '!='])) or \
               stripped.startswith('SetAttributes[') or \
               stripped.startswith('ClearAll[') or \
               stripped.startswith('Unprotect[') or \
               stripped.startswith('Protect['):
                setup_statements.append(stmt + ';')

        return '\n'.join(setup_statements) if setup_statements else ''

    def extract_inter_test_code(self, content: str, tests: List[Dict]) -> Dict[int, str]:
        """
        Extract bare code that appears between VerificationTest blocks.

        This captures variable definitions like $badCatalog = <|...|> that are
        defined outside of VerificationTest blocks but used by later tests.

        Args:
            content: Full file content
            tests: List of all tests (init + actual + cleanup)

        Returns:
            Dict mapping test index -> code that appears before that test
        """
        inter_test_code = {}

        # Sort all tests by start position
        all_tests = sorted(tests, key=lambda t: t['start_pos'])

        # Extract code between consecutive tests
        for i in range(len(all_tests)):
            # Skip i=0: no inter-test code before first test (header is handled separately)
            if i == 0:
                continue

            # Find start of search region (end of previous test)
            search_start = all_tests[i-1]['end_pos']
            search_end = all_tests[i]['start_pos']

            # Extract the region
            region = content[search_start:search_end]

            # Clean up: remove comments and blank lines
            lines = []
            for line in region.split('\n'):
                stripped = line.strip()
                # Skip blank lines and comment-only lines
                if stripped and not stripped.startswith('(*'):
                    lines.append(line)

            code = '\n'.join(lines).strip()

            if code:
                inter_test_code[i] = code

        return inter_test_code

    def generate_single_test_file(self, parsed: Dict, test_index: int) -> str:
        """
        Generate a single test file with only one actual test.

        Init and cleanup tests are unwrapped from VerificationTest blocks
        and included as bare commands.

        State setup from earlier tests is also included if needed.

        Args:
            parsed: Parsed file components from parse_test_file()
            test_index: Index of the actual test to include (0-based)

        Returns:
            Complete file content as string
        """
        parts = [parsed['header']]

        # Add a blank line after header
        parts.append('')

        # Add With bindings (if any) as plain assignments
        if parsed['with_bindings']:
            for binding in parsed['with_bindings']:
                parts.append(binding)
            parts.append('')

        # Add initialization code (unwrapped from VerificationTest)
        if parsed['init_tests']:
            for init_test in parsed['init_tests']:
                code = self.extract_code_from_verification_test(init_test['content'])
                if code:
                    parts.append(code)
            parts.append('')

        # Add state setup from all preceding actual tests and inter-test code
        # BUT: Skip this entirely if we have a wrapper (shared state is in bindings or doesn't exist)
        if not parsed.get('has_wrapper', False):
            state_setup_code = []

            # Collect state from earlier actual tests AND inter-test code
            # We need to interleave them in the correct order based on their positions
            all_tests_sorted = sorted(
                parsed['init_tests'] + parsed['actual_tests'] +
                ([parsed['cleanup_test']] if parsed['cleanup_test'] else []),
                key=lambda t: t['start_pos']
            )

            # Find the position of our target test in the sorted list
            target_test = parsed['actual_tests'][test_index]
            target_pos_in_sorted = next(i for i, t in enumerate(all_tests_sorted) if t['start_pos'] == target_test['start_pos'])

            # Collect all inter-test code that appears before the target test
            for i, code in parsed['inter_test_code'].items():
                if i <= target_pos_in_sorted:
                    state_setup_code.append(('inter', code))

            # Also collect state from within actual tests (before the target)
            for i in range(test_index):
                setup = self.extract_state_setup_from_test(parsed['actual_tests'][i]['content'])
                if setup:
                    # Find position of this test in sorted list to maintain order
                    test_pos = next(j for j, t in enumerate(all_tests_sorted) if t['start_pos'] == parsed['actual_tests'][i]['start_pos'])
                    state_setup_code.append((test_pos, setup))

            # Sort by position and extract just the code
            state_setup_code.sort(key=lambda x: x[0] if isinstance(x[0], int) else -1)
            state_setup_code = [code for _, code in state_setup_code]

            if state_setup_code:
                parts.append('(* === Shared State Setup === *)')
                parts.append('\n\n'.join(state_setup_code))
                parts.append('')

        # Add the single actual test (keep wrapped in VerificationTest)
        if test_index < len(parsed['actual_tests']):
            parts.append(parsed['actual_tests'][test_index]['content'])
            parts.append('')

        # Add cleanup code (unwrapped from VerificationTest)
        if parsed['cleanup_test']:
            code = self.extract_code_from_verification_test(parsed['cleanup_test']['content'])
            if code:
                parts.append(code)
            parts.append('')

        # Add footer
        parts.append(parsed['footer'])

        return '\n'.join(parts)

    def validate_split_file(self, file_path: Path) -> tuple[bool, str]:
        """
        Validate that a split test file has exactly one VerificationTest block.

        Returns:
            (is_valid, error_message)
        """
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()

            # Count VerificationTest blocks
            vt_count = content.count('VerificationTest[')

            if vt_count == 0:
                return False, "No VerificationTest blocks found"
            elif vt_count > 1:
                return False, f"Multiple VerificationTest blocks found: {vt_count}"
            else:
                return True, ""

        except Exception as e:
            return False, f"Error reading file: {str(e)}"

    def split_file(self, source_path: Path) -> None:
        """
        Split a single test file into individual test files.

        Args:
            source_path: Path to the source .wlt file
        """
        try:
            # Parse the file
            parsed = self.parse_test_file(source_path)

            actual_tests = parsed['actual_tests']
            n_tests = len(actual_tests)

            if n_tests == 0:
                print(f"  ⚠️  {source_path.name}: No actual tests found (only init/cleanup)")
                return

            # Determine output directory structure
            relative_path = source_path.relative_to(self.tests_root)
            if len(relative_path.parts) > 1:
                # File is in a subdirectory
                output_subdir = self.output_dir / relative_path.parent
            else:
                # File is in Tests root
                output_subdir = self.output_dir

            output_subdir.mkdir(parents=True, exist_ok=True)

            # Get base name without extension
            base_name = source_path.stem

            # Create individual test files and validate them
            validation_errors = []
            for i in range(n_tests):
                output_name = f"{base_name}_test{i+1}.wlt"
                output_path = output_subdir / output_name

                file_content = self.generate_single_test_file(parsed, i)

                with open(output_path, 'w', encoding='utf-8') as f:
                    f.write(file_content)

                # Validate the generated file
                is_valid, error_msg = self.validate_split_file(output_path)
                if not is_valid:
                    validation_errors.append(f"{output_name}: {error_msg}")

                self.stats['split_files_created'] += 1

            # Also create a copy of the original file for reference
            original_copy_path = output_subdir / f"{base_name}_all.wlt"
            with open(original_copy_path, 'w', encoding='utf-8') as f:
                f.write(parsed['original_content'])

            self.stats['files_processed'] += 1
            self.stats['tests_extracted'] += n_tests

            if validation_errors:
                print(f"  ⚠️  {relative_path}: {n_tests} tests → {n_tests} files (validation errors!)")
                for error in validation_errors:
                    print(f"      - {error}")
                    self.stats['errors'].append(f"{relative_path}: {error}")
            else:
                print(f"  ✓ {relative_path}: {n_tests} tests → {n_tests} files")

        except Exception as e:
            error_msg = f"{source_path.name}: {str(e)}"
            self.stats['errors'].append(error_msg)
            print(f"  ✗ {error_msg}")

    def find_test_files(self) -> List[Path]:
        """
        Find all .wlt files in the Tests directory, excluding specific directories.

        Returns:
            List of Path objects for .wlt files
        """
        exclude_dirs = {'InteractiveTests', 'GenerateCITests', 'temp-tests-inst'}
        test_files = []

        for root, dirs, files in os.walk(self.tests_root):
            # Remove excluded directories from the walk
            dirs[:] = [d for d in dirs if d not in exclude_dirs]

            for file in files:
                if file.endswith('.wlt'):
                    test_files.append(Path(root) / file)

        return sorted(test_files)

    def run(self) -> None:
        """
        Main execution: find and split all test files.
        """
        print("=" * 70)
        print("Test File Splitter")
        print("=" * 70)
        print(f"Source directory: {self.tests_root}")
        print(f"Output directory: {self.output_dir}")
        print()

        # Find all test files
        test_files = self.find_test_files()
        print(f"Found {len(test_files)} test files to process")
        print()

        # Process each file
        for test_file in test_files:
            self.split_file(test_file)

        # Print summary
        print()
        print("=" * 70)
        print("Summary")
        print("=" * 70)
        print(f"Files processed: {self.stats['files_processed']}")
        print(f"Tests extracted: {self.stats['tests_extracted']}")
        print(f"Split files created: {self.stats['split_files_created']}")
        print(f"Errors: {len(self.stats['errors'])}")

        if self.stats['errors']:
            print()
            print("Errors encountered:")
            for error in self.stats['errors']:
                print(f"  - {error}")

        print()
        print(f"Output directory: {self.output_dir}")
        print("=" * 70)

        # Create a log file
        self.write_log()

    def write_log(self) -> None:
        """Write splitting log to file."""
        log_path = self.output_dir / 'splitting_log.txt'

        with open(log_path, 'w', encoding='utf-8') as f:
            f.write("Test File Splitting Log\n")
            f.write("=" * 70 + "\n")
            f.write(f"Date: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"Source directory: {self.tests_root}\n")
            f.write(f"Output directory: {self.output_dir}\n")
            f.write("\n")
            f.write(f"Files processed: {self.stats['files_processed']}\n")
            f.write(f"Tests extracted: {self.stats['tests_extracted']}\n")
            f.write(f"Split files created: {self.stats['split_files_created']}\n")
            f.write(f"Errors: {len(self.stats['errors'])}\n")

            if self.stats['errors']:
                f.write("\nErrors:\n")
                for error in self.stats['errors']:
                    f.write(f"  - {error}\n")

        print(f"Log file created: {log_path}")


def main():
    import sys

    # Determine paths
    script_dir = Path(__file__).parent
    tests_root = script_dir.parent  # Go up to Tests/ directory
    output_dir = script_dir  # Output to temp-tests-inst/

    # Verify we're in the right location
    if not (tests_root / 'RunCoverage.wls').exists():
        print("ERROR: Script must be run from Tests/temp-tests-inst/ directory")
        print(f"Expected to find RunCoverage.wls in {tests_root}")
        return 1

    # Check if we're in test mode (single file)
    if len(sys.argv) > 1 and sys.argv[1] == '--test-single':
        # Test mode: process specific file
        print("=" * 70)
        print("TEST MODE: Processing single file")
        print("=" * 70)

        # Choose test file based on second argument
        if len(sys.argv) > 2:
            test_name = sys.argv[2]
        else:
            test_name = 'normalizeExpNested'  # default

        if test_name == 'bindUnaryMessages':
            test_file = tests_root / 'FindRootOptim' / 'bindUnaryMessages.wlt'
        elif test_name == 'validateModel':
            test_file = tests_root / 'ValidateModels' / 'validateModel.wlt'
        else:
            test_file = tests_root / 'FindRootOptim' / 'normalizeExpNested.wlt'

        if not test_file.exists():
            print(f"ERROR: Test file not found: {test_file}")
            return 1

        splitter = TestFileSplitter(tests_root, output_dir)
        splitter.split_file(test_file)

        print("\n" + "=" * 70)
        print("TEST COMPLETE")
        print("=" * 70)
        print(f"Check output in: {output_dir / test_file.parent.name}")

        return 0

    # Normal mode: run all files
    splitter = TestFileSplitter(tests_root, output_dir)
    splitter.run()

    return 0


if __name__ == '__main__':
    exit(main())
