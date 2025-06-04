open Types

val default_config : build_context
val load_from_toml : string -> build_result
val validate_config : build_context -> build_result
