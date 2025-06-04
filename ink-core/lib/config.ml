open Types

let sprintf = Printf.sprintf
let default_config = { source = "src"; output = "site"; port = 50 }

let load_from_toml path =
  try
    let toml_data = Toml.Parser.(from_filename path |> unsafe) in
    let source =
      Toml.Lenses.(get toml_data (key "source" |-- string)) (* |> Option.get *)
      |> Option.value ~default:default_config.source
    and output =
      Toml.Lenses.(get toml_data (key "output" |-- string)) (* |> Option.get *)
      |> Option.value ~default:default_config.output
    and port =
      Toml.Lenses.(get toml_data (key "port" |-- int))
      (* |> Option.get *)
      |> Option.value ~default:default_config.port
    in
    Ok { source; output; port }
  with
  | Sys_error _ ->
      Error (sprintf "configuration warning. \"%s\" not found" path)
      (* Ok default_config *)
  | exn -> Error (sprintf "TOML parse error. %s" (Printexc.to_string exn))

let validate_config cfg =
  if not (Sys.file_exists cfg.source) then
    Error (sprintf "source directory doesn't exist: %s" cfg.source)
  else if cfg.port < 1 || cfg.port > 65535 then
    Error (sprintf "invalid port: %d" cfg.port)
  else Ok cfg
