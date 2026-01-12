#!/usr/bin/env wolframscript

Needs["PacletTools`"];
PacletDirectoryLoad["."];

(* Load test helpers *)
Get["Tests/TestHelpers.wl"];
Get["Tests/Tools/ToolsTestHelpers.wl"];

(* Load ToNumber package *)
Needs["FernandoDuarte`LongRunRisk`Tools`ToNumber`"];

(* Enable stack trace on messages *)
On[First::nofirst];

(* Test with a single expression first *)
Print["=== Testing with single expression ==="];
result1 = toNum[wc[t], $modNRC];
Print["Single expression result type: ", Head[result1]];

Print["\n=== Testing with list of 2 expressions ==="];
testList = {wc[t], pd[t, 1]};
result2 = toNum[testList, $modNRC];
Print["List result type: ", Head[result2]];
