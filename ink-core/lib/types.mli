type file_event = Created of string | Modified of string | Deleted of string
type build_context = { source : string; output : string; port : int }
type build_result = (build_context, string) result

val string_of_file_event : file_event -> string
