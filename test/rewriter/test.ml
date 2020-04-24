let saludo = [%spf "Hi there."]

let first_name = "O"

let last_name = "Caml"

let introduction = [%spf "My name is {first_name}."]

let formal_intro = [%spf "My name is {first_name}{last_name}."]
