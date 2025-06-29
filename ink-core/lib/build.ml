open File_utils

let run_build src out exts =
  let all_files = find_files [ src ] in
  Printf.printf "found %d files in total.\n" (List.length all_files);
  let ext_procs = List.map Ext_process.spawn_ext exts in

  List.iter
    (fun ext ->
      Ext_process.send_to_ext ext (Build all_files);
      match Ext_process.rec_from_ext ext with
      | Done out_files ->
          Printf.printf "Extension processed: %s\n"
            (String.concat ", " out_files)
      | Error msg -> Printf.printf "Extension error: %s\n" msg)
    ext_procs;
  List.iter Ext_process.close_ext ext_procs
