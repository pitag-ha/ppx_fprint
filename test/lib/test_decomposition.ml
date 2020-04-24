let test_decomposition =
  Alcotest.testable Ppx_fprint_lib.Decomposition.pp
    Ppx_fprint_lib.Decomposition.equal

let test_parse_string =
  let make_test ~input ~expected =
    let name = Printf.sprintf "Decomposition.parse_string \"%s\"" input in
    let test_fun () =
      Alcotest.(check (Alcotest_ext.rresult test_decomposition string)
        name expected
        (Ppx_fprint_lib.Decomposition.parse_string input))
    in
    (name, `Quick, test_fun)
  in
  [
    make_test ~input:"Hi there." ~expected:(Ok("Hi there.", []));
    make_test ~input:"My name is {first_name}." ~expected:(Ok("My name is %s.", ["first_name"]));
    make_test ~input:"My name is {first_name}{last_name}." ~expected:(Ok("My name is %s%s.", ["first_name"; "last_name"]));
    make_test ~input:"My name is {first{name}." ~expected:(Error(Ppx_fprint_lib.Decomposition.invalid_var_err_msg));
    make_test ~input:"My name is {first}name}." ~expected:(Error(Ppx_fprint_lib.Decomposition.spare_right_bracket_err_msg));
    make_test ~input:"My name is {first_name" ~expected:(Error(Ppx_fprint_lib.Decomposition.spare_left_bracket_err_msg));
  ]
