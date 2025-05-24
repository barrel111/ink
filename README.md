# Ink

The best static site generator is the one that gets out of your way.

Ink keeps the core lean—just file watching and a development server. Everything else happens through extensions you write.

## Quick Start

```bash
# Install
opam install ink

# Initialize a new site
ink init my-site
cd my-site

# Start development server
ink serve

# Build for production
ink build
```

## Architecture

Ink's core handles three things:

1. **File Watching** - Monitors your source directory for changes
2. **Development Server** - Serves files with live reload via WebSocket
3. **Extension Coordination** - Loads and orchestrates your extensions

Everything else is an extension:

```ocaml
module My_Extension : Ink.EXTENSION = struct
  let name = "my-extension"
  
  let handles_file filename = 
    Filename.extension filename = ".md"
  
  let process_file ctx filepath =
    (* Your markdown processing logic *)
    Lwt.return_unit
end
```

## Built-in Extensions

Ink comes with a few essential extensions:

- **Markdown** - CommonMark processing with syntax highlighting
- **Dependencies** - Tracks file dependencies for incremental builds  
- **Assets** - Copies static assets to output directory
- **Templates** - Basic HTML templating

## Configuration

Create an `ink.toml` in your project root:

```toml
source_dir = "src"
output_dir = "_site"
port = 8080

[extensions]
markdown = { syntax_highlighting = true }
templates = { layout_dir = "layouts" }
```

## Writing Extensions

Extensions implement the `EXTENSION` interface:

```ocaml
module type EXTENSION = sig
  val name : string
  val init : build_context -> unit Lwt.t
  val handles_file : string -> bool
  val process_file : build_context -> string -> unit Lwt.t
  val post_build : build_context -> unit Lwt.t
  val cleanup : unit -> unit Lwt.t
end
```

Extensions can:
- Transform file content
- Generate new files
- Add routes to the dev server
- Hook into the build pipeline

## Example Project Structure

```
my-site/
├── ink.toml              # Configuration
├── src/                  # Source content
│   ├── index.md
│   ├── posts/
│   │   └── hello.md
│   └── assets/
│       └── style.css
├── layouts/              # Templates
│   └── base.html
├── extensions/           # Custom extensions
│   └── my_extension.ml
└── _site/               # Generated output
```

## Development

```bash
# Clone and build
git clone https://github.com/yourusername/ink.git
cd ink
dune build

# Run tests
dune test

# Install locally
dune install
```

