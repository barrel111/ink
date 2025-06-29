open Ink_ext.Protocol
open Sexplib

type ext_process = {
  name : string; [@warning "-69"]
  from_ext : in_channel;
  to_ext : out_channel;
}

let spawn_ext name =
  let cmd = name ^ "_ext" in
  let from_ext, to_ext = Unix.open_process cmd in
  { name; from_ext; to_ext }

let send_to_ext ext msg =
  let sexp = sexp_of_ext_msg msg in
  output_string ext.to_ext (Sexp.to_string sexp ^ "\n");
  flush ext.to_ext

let rec_from_ext ext =
  let line = input_line ext.from_ext in
  Sexp.of_string line |> main_msg_of_sexp

let close_ext ext =
  send_to_ext ext Shutdown;
  close_out ext.to_ext;
  close_in ext.from_ext
