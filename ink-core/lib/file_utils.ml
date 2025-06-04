let rec find_files ?(res = []) = function
  | path :: paths when Sys.is_directory path ->
      let subdirs =
        Sys.readdir path |> Array.map (Filename.concat path) |> Array.to_list
      in
      find_files ~res (paths @ subdirs)
  | path :: paths -> find_files ~res:(path :: res) paths
  | [] -> res
