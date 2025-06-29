let run_build src out exts =
  if not (Sys.file_exists out) then Unix.mkdir out 0o755;
  let all_files = File_utils.find_files [ src ] in
  Printf.printf "found %d files in total.\n" (List.length all_files);
  let ext_procs = List.map Ext_proc.spawn_ext exts in

  List.iter
    (fun ext ->
      Ext_proc.send_to_ext ext (Build (all_files, out));
      match Ext_proc.rec_from_ext ext with
      | Done out_files ->
          Printf.printf "Extension processed: %s\n"
            (String.concat ", " out_files)
      | Error msg -> Printf.printf "Extension error: %s\n" msg)
    ext_procs;
  List.iter Ext_proc.close_ext ext_procs
