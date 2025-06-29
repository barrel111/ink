(lang dune 3.18)

(package
 (name ink-core)
 (depends ocaml dune lwt lwt_unix toml ink-ext))

(package
 (name ink-ext)
 (depends ocaml dune ink-core lwt sexplib ppx_sexp_conv))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
