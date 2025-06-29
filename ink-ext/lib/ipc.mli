open Protocol

val send_message : main_msg -> unit
val receive_message : unit -> ext_msg
val extension_loop : (string list -> string list) -> unit

