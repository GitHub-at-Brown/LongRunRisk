VerificationTest[
  Module[{count = 200, offset = 0, noop = 0, veryLongVariableNameForWidthCheck = 1},
    Range[count] * veryLongVariableNameForWidthCheck +
      offset - noop
  ],
  Append[Range[199], 999999],
  TestID -> "FakeFailingTest_LongInput_TEMP@@Tests/_Debug/FakeFailingTest_test1.wlt:1,1-9,2"
]

