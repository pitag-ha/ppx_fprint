(lang dune 2.4)
(name ppx_fprint)
(allow_approximate_merlin)

(generate_opam_files true)
(source (github pitag-ha/ppx_fprint))
(maintainers "Sonja Heinze <sonjaleaheinze@gmail.com>")
(authors "Sonja Heinze <sonjaleaheinze@gmail.com>")

(package
 (name ppx_fprint)
 (synopsis "PPX-extension for strings including string identifiers wrapped in curly brackets.")
 (description "\
Given a string including string identifiers wrapped in curly brackets, this PPX-extension replaces the identifiers in that string with their correspondent values. \
")
 (depends alcotest rresult ppx_deriving))
