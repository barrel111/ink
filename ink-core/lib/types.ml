type file_event = Created of string | Modified of string | Deleted of string
type build_context = { source : string; output : string; port : int }
type build_result = (build_context, string) result

let string_of_file_event = function
  | Created s -> Printf.sprintf "Created: %s" s
  | Modified s -> Printf.sprintf "Modified: %s" s
  | Deleted s -> Printf.sprintf "Deleted: %s" s
