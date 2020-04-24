type t = string * string list [@@deriving show, eq]

type loc_in_string = In_var | In_string

val invalid_var_err_msg : string

val spare_right_bracket_err_msg : string

val spare_left_bracket_err_msg : string

val parse_string : string -> (t, string) Rresult.result
