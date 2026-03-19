# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a **custom Neovim configuration** using [Lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. It is not based on NvChad or any other distribution — all configuration is hand-written.

## Architecture

- **Plugin Management**: Lazy.nvim (auto-bootstrapped in `lua/config/lazy.lua`)
- **Entry point**: `init.lua` — loads `config.lazy`, `config.keymaps`, `config.autocmds`
- **Configuration files**:
  - `lua/config/lazy.lua`: Bootstraps Lazy.nvim, sets leader keys, imports `lua/plugins/`
  - `lua/config/keymaps.lua`: All custom keybindings
  - `lua/config/options.lua`: Editor options
  - `lua/config/autocmds.lua`: Autocommands
  - `lua/plugins/init.lua`: All plugin specs and inline configuration

## Installed Plugins

- `conform.nvim`: Code formatting (`<leader>fm`)
- `which-key.nvim`: Keymap popup hints
- `telescope.nvim`: Fuzzy finder (`<leader>tf`)
- `harpoon` (harpoon2 branch): File navigation (`<leader>h*`)
- `mason.nvim` + `mason-lspconfig.nvim` + `nvim-lspconfig`: LSP auto-install and setup
- `gitsigns.nvim`: Git blame and change signs
- `catppuccin/nvim`: Colorscheme
- `nvim-tree.lua`: File tree sidebar (right side, opens on VimEnter)
- `nvim-web-devicons`: File icons
- `toggleterm.nvim`: Integrated terminal
- `nvim-treesitter`: Syntax highlighting

## Key Mappings

- `<leader>ha` — Harpoon add file
- `<leader>he` — Harpoon quick menu
- `<leader>h1`–`<leader>h4` — Jump to harpoon slots (which-key shows filename dynamically)
- `<leader>hh` / `<leader>hl` — Harpoon prev/next
- `<leader>tf` — Telescope find files
- `<leader>fm` — Format file (conform)
- `<leader>BB` — Toggle nvim-tree
- `<leader>ef/el/eh` — Diagnostic float/next/prev
- `<C-h/j/k/l>` — Window navigation

## File Structure

```
nvim/
├── init.lua                  # Entry point
├── lazy-lock.json            # Locked plugin versions
├── .stylua.toml              # Stylua formatting config (2 spaces)
└── lua/
    ├── config/
    │   ├── lazy.lua          # Lazy.nvim bootstrap and setup
    │   ├── keymaps.lua       # All keybindings
    │   ├── options.lua       # Editor options
    │   └── autocmds.lua      # Autocommands
    └── plugins/
        └── init.lua          # All plugin specs
```

## When Making Changes

- **Plugin Additions**: Add to `lua/plugins/init.lua` using Lazy spec format
- **Keybindings**: Add to `lua/config/keymaps.lua`
- **Editor Options**: Add to `lua/config/options.lua`
- **Autocommands**: Add to `lua/config/autocmds.lua`
- **Formatting**: Use `<leader>fm` in Neovim to format with conform
- **Git**: All git commands are forbidden — suggest only, never run

## Lua Diagnostics Notes

`vim` is a Neovim runtime global — undefined variable warnings from the Lua LSP are expected and can be ignored.
