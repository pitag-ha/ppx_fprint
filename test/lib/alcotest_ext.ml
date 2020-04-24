open Alcotest
open Rresult

let rresult a e =
  let eq x y =
    match (x, y) with
    | Ok x, Ok y -> equal a x y
    | Error x, Error y -> equal e x y
    | _ -> false
  in
  testable (Fmt.Dump.result ~ok:(pp a) ~error:(pp e)) eq