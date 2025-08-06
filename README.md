# Per-Project ShaDa

**pshada** is a NeoVim lua plugin that automatically reads and writes a
separate ShaDa (shared data) file per project. The ShaDa file is used to store
marks, command line history and more, see `:help shada`.

## Install

Install with your preferred package manager:

### Lazy

```lua
{
    "mart-mihkel/pshada.nvim",
    opts = {
        -- your options here, leave empty for defaults
    },
}
```

### Native `vim.pack` (NeoVim Nightly)

```lua
vim.pack.add({
    "https://github.com/mart-mihkel/pshada.nvim"
})

require("pshada").setup()
```

## Configurations

pshada comes with the following defaults:

```lua
{
    -- filenames used to decide if workdir is a project
    root_markers = { ".git" },
}
```
