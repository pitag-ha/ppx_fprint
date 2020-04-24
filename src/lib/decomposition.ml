open Rresult

type t = string * string list [@@deriving show, eq]

type loc_in_string = In_var | In_string

let invalid_var_err_msg =  "Syntax error in spf payload: variable names cannot contain brackets."
let spare_right_bracket_err_msg =  "Syntax error in spf payload: found a right bracket without matching left bracket."
let spare_left_bracket_err_msg = "Syntax error in spf payload: found a left bracket without matching right bracket."

let parse_string str =
  let parse_char char (string, vars, loc_in_string) =
    match (loc_in_string, char) with
    | In_var, "}" -> Ok (string, vars, In_string)
    | In_var, "{" -> Error invalid_var_err_msg
    | In_var, _ -> (
        match vars with
        | var :: tl -> Ok (string, (var ^ char) :: tl, In_var)
        (* Theoretically, this never happens *)
        | _ -> Error "Ppx_fprint parse error." )
    | In_string, "{" -> Ok (string ^ "%s", "" :: vars, In_var)
    | In_string, "}" -> Error spare_right_bracket_err_msg
    | In_string, _ -> Ok (string ^ char, vars, In_string)
  in
  Seq.fold_left
    (fun part_res char -> part_res >>= parse_char char)
    (Ok ("", [], In_string))
    (Seq.map (String.make 1) (String.to_seq str))
  >>= function
  | _, _, In_var ->
      Error spare_left_bracket_err_msg
  | string, vars, _ -> Ok (string, List.rev vars)
