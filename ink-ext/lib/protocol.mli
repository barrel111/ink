open Sexplib

type ext_msg = Build of string list | Shutdown
type main_msg = Done of string list | Error of string

val sexp_of_ext_msg : ext_msg -> Sexp.t
val ext_msg_of_sexp : Sexp.t -> ext_msg
val sexp_of_main_msg : main_msg -> Sexp.t
val main_msg_of_sexp : Sexp.t -> main_msg
