BeginTestSection["only-quad-terms"]

Needs["FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`"];


pqs = FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve;

VerificationTest[
  pqs[{x + y == 1}, {x, y}, "OnlyQuadTerms" -> True] === $Failed,
  True,
  {FernandoDuarte`LongRunRisk`ComputationalEngine`ParamQuadSolve`paramQuadSolve::noquad},
  TestID -> "onlyquad-noquadratic@@Tests/ParamQuadSolve/only-quad-terms_test4.wlt:8,1-13,2"
]

EndTestSection[]
