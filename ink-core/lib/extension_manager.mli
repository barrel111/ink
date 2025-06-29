open Hooks
open Types

val register_extension : string -> hook list -> unit
val run_config_hooks : Toml.Types.table -> unit Lwt.t
val run_pre_build_hooks : build_context -> file_event list -> unit Lwt.t
val run_build_hooks : build_context -> unit Lwt.t
val run_assembly_hooks : build_context -> unit Lwt.t
