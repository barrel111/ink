open Sexplib.Std

type ext_msg = Build of string list * string | Shutdown [@@deriving sexp]
type main_msg = Done of string list | Error of string [@@deriving sexp]
