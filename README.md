# Per-Project ShaDa

**pshada** is a NeoVim plugin that automatically reads and writes a separate
ShaDa (shared data) file per project. The ShaDa file is used to store marks,
command line history and more, see `:help shada`.

## Install

```lua
vim.pack.add({
    "https://github.com/mart-mihkel/pshada.nvim"
})

require("pshada").setup({
    -- your options here, leave empty for defaults
})
```

## Configuration

### Defaults

```lua
{
    -- filenames used to decide if workdir is a project
    root_markers = { ".git" },
}
```
