# Treesitter Zig Parser Fix

When `nvim-treesitter` auto-updates via Lazy, it can wipe the Zig parser and query
files. The `:TSInstall zig` command may hang on "Compiling parser" and never finish.

## Symptoms

- Zig syntax highlighting partially or fully broken after a plugin update
- `:TSInstall zig` hangs on "Compiling parser"

## Manual Fix

```bash
# Clone the grammar
cd /tmp
git clone https://github.com/tree-sitter-grammars/tree-sitter-zig.git

# Compile the parser
cd tree-sitter-zig/src
gcc -shared -o zig.so -fPIC parser.c

# Copy parser and query files into nvim-treesitter
cp zig.so ~/.local/share/nvim/lazy/nvim-treesitter/parser/zig.so
mkdir -p ~/.local/share/nvim/lazy/nvim-treesitter/queries/zig
cp /tmp/tree-sitter-zig/queries/* ~/.local/share/nvim/lazy/nvim-treesitter/queries/zig/
```

Restart Neovim after running these commands.
