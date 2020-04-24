open Ppxlib

let expand_function ~loc ~path:_ str =
  match Ppx_fprint_lib.Decomposition.parse_string str with
  | Error msg -> failwith msg
  | Ok (string, vars) ->
      let make_expression pexp_desc =
        { pexp_attributes = []; pexp_loc = loc; pexp_loc_stack = []; pexp_desc }
      in
      let make_ident_desc long_ident = Pexp_ident { txt = long_ident; loc } in
      let make_string_desc string =
        Pexp_constant (Pconst_string (string, None))
      in
      make_expression
        (Pexp_apply
           ( make_ident_desc (Ldot (Lident "Printf", "sprintf"))
             |> make_expression,
             (Nolabel, make_string_desc string |> make_expression)
             :: List.map
                  (fun var ->
                    (Nolabel, make_ident_desc (Lident var) |> make_expression))
                  vars ))

let extension =
  Extension.declare "spf" Extension.Context.expression
    Ast_pattern.(single_expr_payload (estring __))
    expand_function

let rule = Context_free.Rule.extension extension

let () = Driver.register_transformation ~rules:[ rule ] "fprint_transformation"
