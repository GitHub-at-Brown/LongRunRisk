LongRunRiskDebug`veryLongMessageNameForWidthCheckOfActualMessages =
  "Debug message with long content: `1`";

VerificationTest[
  Module[
    {
      count = 200,
      offset = 0,
      noop = 0,
      veryLongVariableNameForWidthCheck = 1,
      longMsg
    },
    longMsg = StringJoin[
      "This is a really really long message used to verify GHA summary rendering. ",
      "It should exceed eighty characters and span multiple clauses for width checks. ",
      "0123456789-ABCDEFGHIJKLMNOPQRSTUVWXYZ-0123456789"
    ];
    Message[
      LongRunRiskDebug`veryLongMessageNameForWidthCheckOfActualMessages,
      longMsg
    ];
    Range[count] * veryLongVariableNameForWidthCheck +
      offset - noop
  ],
  Append[Range[199], 999999],
  TestID ->
    "FakeFailingTest_LongMessage_TEMP@@Tests/_Debug/FakeFailingTest_test1.wlt:4,1-28,2"
]
