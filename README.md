# LongRunRisk
Tools to solve and analyze long-run risk models

[Quick Start guide in the Wolfram Cloud](https://www.wolframcloud.com/obj/cbfd32dd-6b7c-449d-8c4e-7538790d0f34).

Or download [QuickStart.nb](Documentation/English/Guides/QuickStart.nb) from the repository and use it locally in your computer.


To do:
- after simplifyCoeffsSystem and before solveCoeffsSystem Simplify::gtime message is issued inside LocalEvaluate. Find the exact place where that happens
- after constructing the jacobian, and before any other manipulation (e.g., before flattening), add a simplify with local evaluate and block $HistoryLength and hard time constraint
- since the message was issued for Put not Get for DefinitionData, no warmup needed?
- remove matex paclet file 
- wrap all expensive ops in local evaluate and block $history length = 0 and create a helper for it to not repeat yourself
- check number of kernels in all parallel kernel executions, should be not hardwired/magical, either auto detect or pass option.