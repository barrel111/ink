open Protocol
open Sexplib

let send_message msg =
  let sexp = sexp_of_main_msg msg in
  Printf.printf "%s\n%!" (Sexp.to_string sexp)

let receive_message () =
  let line = input_line stdin in
  Sexp.of_string line |> ext_msg_of_sexp

let extension_loop process_files =
  try
    while true do
      match receive_message () with
      | Build (files, out_dir) ->
          let outputs = process_files files out_dir in
          send_message (Done outputs)
      | Shutdown -> exit 0
    done
  with End_of_file -> exit 0
