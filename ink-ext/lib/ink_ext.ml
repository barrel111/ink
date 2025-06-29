module Protocol = Protocol
module Ipc = Ipc

(* Simple API for extensions *)
let run_extension ~process_files = Ipc.extension_loop process_files
