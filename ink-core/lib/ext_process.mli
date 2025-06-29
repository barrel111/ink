type ext_process

val spawn_ext : string -> ext_process
val send_to_ext : ext_process -> Ink_ext.Protocol.ext_msg -> unit
val rec_from_ext : ext_process -> Ink_ext.Protocol.main_msg
val close_ext : ext_process -> unit
