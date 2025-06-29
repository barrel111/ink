type ext_proc

val spawn_ext : string -> ext_proc
val send_to_ext : ext_proc -> Ink_ext.Protocol.ext_msg -> unit
val rec_from_ext : ext_proc -> Ink_ext.Protocol.main_msg
val close_ext : ext_proc -> unit
val name : ext_proc -> string
