### Catalog.wl
- Symbol models
  - is an association
  - its keys are strings
     ```
     And @@ (StringQ /@ Keys[models])
     ```
For each model (each entry of models)
  - is an association
  ```
   And @@ (MatchQ[
      Association, #] & /@ (Flatten@{Head[models],
       Head[models[#]] & /@ Keys[models]}))
  ```
  - its keys are strings

  - keys are exactly the set {"name", "shortname", "bibRef", "desc", "enabled", "parameters"} (not ordered)
  - "name", "shortname", "bibRef", "desc" are strings
    ```
    And @@ (StringQ /@
    Flatten@({models[#]["name"], models[#]["shortname"], models[#]["bibRef"],
    models[#]["desc"]} & /@ Keys[models]))
    ```
  - "bibRef" is either "None" or "none" or a string matching one of the reference keys in Resources/BibTeX/references.bib
    - For example, des2023stocksbonds is the key of the first entry in Resources/BibTeX/references.bib, so "bibRef" -> "des2023stocksbonds" should pass the test
  - "enabled" in Boolean (True or False)
    ```
    And @@ (BooleanQ /@ Flatten@({models[#]["enabled"]} & /@ Keys[models]))
    ```
  - "stateVars" is a list
  - "parameters" is a list of rules
  - "parameters" evaluates to numbers after applying "parameters" repeatedly to values
    ```
    And @@ (NumberQ /@
    Flatten[(models[#]["parameters"][[;; , 2]] //. models[#]["parameters"]) & /@ Keys[models]])
    ```
  - exogenous variables are in context "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`
    ```
    And @@ ((And @@ ((# ===
                "FernandoDuarte`LongRunRisk`Model`ExogenousEq`Private`") & /@ \
    (Context /@
              Cases[models[#]["stateVars"],
                var_Symbol?(MemberQ[
                      StringDrop[#, -2] & /@
                      FernandoDuarte`LongRunRisk`Model`ExogenousEq`$\
    exogenousVars, SymbolName[#]] &)[__] :> var, Infinity]))) & /@ Keys[models])
    ```
    - shocks are in context "FernandoDuarte`LongRunRisk`Model`Shocks`
      ```
      And @@ ((And @@ ((# ===
                  "FernandoDuarte`LongRunRisk`Model`Shocks`") & /@ (Context /@
                Cases[models[#]["stateVars"],
                  var_Symbol?(MatchQ[SymbolName[#], "eps"] &)[__][__] :> var,
                  Infinity]))) & /@ Keys[models])
      ```
    - all parameters are in context "FernandoDuarte`LongRunRisk`Model`Parameters`"
      ```
      And @@ ((And @@ ((# ===
                  "FernandoDuarte`LongRunRisk`Model`Parameters`") & /@ (Context /@
                Cases[models[#]["parameters"],
                  var_Symbol?(MemberQ[
                      FernandoDuarte`LongRunRisk`Model`Parameters`$parameters,
                      SymbolName[#]] &) :> var, Infinity]))) & /@ Keys[models])
      ```
    - state variables do not have any endogenous variables
    ```
    And @@ (MatchQ[{}, #] & /@ (Cases[models[#]["stateVars"],
            var_Symbol?(MemberQ[
                  StringDrop[#, -2] & /@
                  FernandoDuarte`LongRunRisk`Model`EndogenousEq`$endogenousVars,
                  SymbolName[#]] &)[__] :> var, Infinity] & /@ Keys[models]))
    ```
- Symbol modelsExtraInfo
  - is an association

```
 And @@ {
   AllTrue[modelsExtraInfo, AssociationQ],
   AllTrue[modelsExtraInfo[#] & /@ Keys[modelsExtraInfo], AssociationQ]
   }
```
- models in modelsExtraInfo are a subset of those defined in models
```
 And @@ {
   SubsetQ[Keys[models], Keys[modelsExtraInfo]]
   }
```
- if provided, initial guess for Ewc is a vector and for Epd is 2-dimensional array
```
 And @@ (
   Flatten@(
     If[KeyExistsQ[modelsExtraInfo[#], "initialGuess"]
        ,
        {
         If[KeyExistsQ[modelsExtraInfo[#]["initialGuess"], "Ewc"],
          VectorQ["Ewc" /. modelsExtraInfo[#]["initialGuess"]] , True]
         ,
         If[KeyExistsQ[modelsExtraInfo[#]["initialGuess"], "Epd"],
          ArrayQ["Epd" /. modelsExtraInfo[#]["initialGuess"], 2] , True]
         }
        ,
        True
        ] & /@ Keys[modelsExtraInfo]
     )
   )
```
- Load `Needs["FernandoDuarte`LongRunRisk`Tools`ValidateModels`"]`, test that validateCatalog[models]["Valid"] is True
