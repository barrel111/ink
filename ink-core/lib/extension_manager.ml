open Hooks

let config_hooks = ref []
let pre_build_hooks = ref []
let build_hooks = ref []
let assembly_hooks = ref []

let register_extension name =
  List.iter (function
    | Config f -> config_hooks := (name, f) :: !config_hooks
    | PreBuild f -> pre_build_hooks := (name, f) :: !pre_build_hooks
    | Build f -> build_hooks := (name, f) :: !build_hooks
    | Assembly f -> assembly_hooks := (name, f) :: !assembly_hooks)

let run_config_hooks cfg =
  Lwt_list.iter_p
    (fun (name, hook) ->
      let ext_cfg =
        Toml.Lenses.(
          get cfg (key "extensions" |-- table |-- key name |-- table))
      in
      hook ext_cfg)
    !config_hooks

let run_pre_build_hooks _ctx _files = failwith "todo!"
let run_build_hooks _ctx = failwith "todo!"
let run_assembly_hooks _ctx = failwith "todo!"
