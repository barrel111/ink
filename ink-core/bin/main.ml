open Ink_core.File_utils
open Ink_core.Config

let load_from_args () =
  let config = ref default_config in
  let source s = config := { !config with source = s } in
  let output s = config := { !config with output = s } in
  let port d = config := { !config with port = d } in

  let speclist =
    [
      ("--source", Arg.String source, "source directory");
      ("--output", Arg.String output, "output directory");
      ("--port", Arg.Int port, "port for the live server");
    ]
  in
  let usage = "ink [--source] source_dir [--output] output_dir [--port] port" in

  Arg.parse speclist (fun _ -> ()) usage;
  !config

let load_config () =
  match load_from_toml "ink.toml" with
  | Ok cfg ->
      let update_diff m d o = if m <> d then m else o in
      let mod_cfg = load_from_args () in
      {
        source = update_diff mod_cfg.source default_config.source cfg.source;
        output = update_diff mod_cfg.output default_config.output cfg.output;
        port = update_diff mod_cfg.port default_config.port cfg.port;
      }
      |> validate_config
  | Error str ->
      Printf.printf "%s\n" str;
      load_from_args () |> validate_config

let () =
  print_endline "";
  match load_config () with
  | Ok cfg ->
      Printf.printf
        "ink configuration.\n\tsource: %s\n\toutput: %s\n\tport: %d\n"
        cfg.source cfg.output cfg.port;
      let files = find_files [ cfg.source ] |> String.concat "," in
      Printf.printf "%s\n" files
  | Error str -> Printf.printf "configuration error. %s\n" str
