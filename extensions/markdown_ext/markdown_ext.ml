open Ink_ext

let process_markdown_file file out =
  if Filename.extension file = ".md" then (
    let content = In_channel.with_open_text file In_channel.input_all in
    let html_content = Omd.of_string content |> Omd.to_html in
    let base_name = Filename.basename file in
    let html_name = Filename.remove_extension base_name ^ ".html" in
    let output_file = Filename.concat out html_name in
    Out_channel.with_open_text output_file (fun oc ->
        Out_channel.output_string oc html_content);
    [ output_file ])
  else []
