# ppx_fprint

This is a PPX-extension for strings that include string identifiers wrapped in curly brackets. This PPX replaces every identifier in such a string with its correspondent value. It does so by expanding a given extension node `[%spf <string conatining {var_1} ... {var_n}>]` to `Printf.sprintf <correspondent format string> var_1 ... var_n`.

## Installation

```
opam pin add --yes https://github.com/pitag-ha/ppx_fprint.git
opam install ppx_fprint
```

If you want to contribute to the project, please read
[CONTRIBUTING.md](CONTRIBUTING.md).


## Usage

The extension name is `spf`, so you can use the extension via `[%spf <payload>]`, where `<payload>` is a string, possibly containing identifiers wrapped in curly brackets.

### Example

The lines
```
let first_name = "O"
let last_name = "Caml"
Printf.printf [%spf "My name is {first_name}{last_name}."]
```
print out `My name is OCaml`.