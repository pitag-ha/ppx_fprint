let () =
  Logs.set_level (Some Logs.Debug);
  Logs.set_reporter (Logs_fmt.reporter ());
  Alcotest.run "ppx_fprint" [ ("Decomposition", Test_decomposition.test_parse_string) ]