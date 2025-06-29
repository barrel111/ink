module Protocol : module type of Protocol
module Ipc : module type of Ipc

val run_extension : process_files:(string list -> string -> string list) -> unit
