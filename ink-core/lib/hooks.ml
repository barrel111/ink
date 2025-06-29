open Types

type config_hook = Toml.Types.table option -> unit Lwt.t
type pre_build_hook = build_context -> file_event list -> unit Lwt.t
type build_hook = build_context -> unit Lwt.t
type assembly_hook = build_context -> unit Lwt.t

type hook =
  | Config of config_hook
  | PreBuild of pre_build_hook
  | Build of build_hook
  | Assembly of assembly_hook
