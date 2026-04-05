# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a **Neovim configuration** [Package Manager: Lazy.nvim] — all configuration is hand-written.

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
- `nvim-lualine/lualine.nvim`: Statusline
- `saghen/blink.cmp`: Autocompletion (Tab/S-Tab to navigate, CR to accept)
- `fzf-lua`: Fuzzy finder (`<leader>l*`)
- `harpoon` (harpoon2 branch): File navigation (`<leader>h*`)
- `mason.nvim` + `mason-lspconfig.nvim` + `nvim-lspconfig`: LSP auto-install and setup
- `catppuccin/nvim`: Colorscheme (macchiato flavour)
- `nvim-web-devicons`: File icons

## Key Mappings

- `<leader>bd` — Close buffer
- `<leader>ha` — Harpoon add file
- `<leader>he` — Harpoon quick menu
- `<leader>h1`–`<leader>h9` — Jump to harpoon slots (which-key shows filename dynamically)
- `<leader>hh` / `<leader>hl` — Harpoon prev/next
- `<leader>lf` — fzf-lua find files
- `<leader>lg` — fzf-lua live grep
- `<leader>lr` — fzf-lua recent files
- `<leader>ls` — fzf-lua search word under cursor
- `<leader>lk` — fzf-lua keymaps
- `<leader>lb` — fzf-lua buffers
- `<leader>fm` — Format file (conform)
- `<leader>gg` — Open LazyGit (wezterm split pane via `wezterm cli split-pane`)
- `<leader>ef` — Diagnostic float
- `<leader>ej` / `<leader>ek` — Next/prev diagnostic
- `<leader>ed` — Go to definition
- `<leader>eD` — Go to declaration
- `<leader>eh` — Hover (LSP)
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

## Notes

- Treesitter is used as a **Neovim built-in** (no plugin) — `autocmds.lua` calls `pcall(vim.treesitter.start)` on every `FileType` event for syntax highlighting
- On `VimEnter`, Harpoon slot 1 is auto-selected and the initial empty buffer is deleted — this is intentional behavior in `autocmds.lua`
- `vim` is a Neovim runtime global — undefined variable warnings from the Lua LSP are expected and can be ignored

## Wezterm Configuration

- Config is at `wezterm/wezterm.lua` — symlinked to `~/.config/wezterm/wezterm.lua` by `install.sh`
- Use `wezterm.home_dir` instead of hardcoded paths in `args` (shell variables like `$HOME` are not expanded)
