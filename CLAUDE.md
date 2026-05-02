# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repo manages hand-written config sets — Neovim, tmux, WezTerm, and Helix — installed via `install.sh`.

## Installation

```bash
./install.sh
```

Symlinks `nvim/` → `~/.config/nvim`, `tmux/tmux.conf` → `~/.config/tmux/tmux.conf`, and `helix/` → `~/.config/helix`. Appends a `config-file` directive to `~/.config/ghostty/config.ghostty` pointing to `ghostty/config`.

## Neovim

**Package manager**: Lazy.nvim (auto-bootstrapped in `lua/config/lazy.lua`)

**Entry point**: `init.lua` loads `config.lazy`, `config.keymaps`, `config.autocmds`

**Where to make changes**:
- Plugins: `lua/plugins/init.lua` (all specs and inline config in one file)
- Keybindings: `lua/config/keymaps.lua`
- Editor options: `lua/config/options.lua`
- Autocommands: `lua/config/autocmds.lua`

**Installed plugins**: conform.nvim, which-key.nvim, lualine.nvim, blink.cmp, fzf-lua, mason.nvim + mason-lspconfig + nvim-lspconfig, catppuccin, nvim-web-devicons

### Key Mappings

- `<leader>bd` — Close buffer
- `<leader>lf` / `<leader>lg` / `<leader>lr` / `<leader>ls` / `<leader>lb` / `<leader>lm` — fzf-lua: files, live grep, recent, word under cursor, buffers, marks
- `<leader>fm` — Format file (conform)
- `<leader>gg` — Open LazyGit (floating terminal)
- `<leader>ef` — Diagnostic float; `<leader>ej`/`<leader>ek` — next/prev diagnostic
- `<leader>ed` / `<leader>eD` / `<leader>eh` — LSP: definition, declaration, hover
- `<C-h/j/k/l>` — Window navigation

**Global marks** (`A`–`Z`, persist via shada):
- `<leader>MaA`–`<leader>MaZ` — Set mark (confirms before overwriting an occupied slot)
- `<leader>MA`–`<leader>MZ` — Jump to mark
- `<leader>MdA`–`<leader>MdZ` — Delete mark
- Lualine shows 🐡 + letter when current file is marked, 🙈 otherwise

### Notes

- Treesitter runs as a **Neovim built-in** (no plugin) — `autocmds.lua` calls `pcall(vim.treesitter.start)` on every `FileType` event
- `vim` is a Neovim runtime global — Lua LSP undefined-variable warnings for it are expected and ignorable
- Formatting config: `.stylua.toml` (2 spaces)
- **Git commands are forbidden** — suggest only, never run

## tmux

Config: `tmux/tmux.conf`

- **Prefix**: `C-Space`
- **Splits**: `prefix + h` (horizontal), `prefix + v` (vertical), both open in current path
- **Pane navigation**: `Alt+h/j/k/l` (no prefix needed)
- **Pane resize**: `Alt+H/J/K/L`
- **Window navigation**: `Shift+Left/Right`
- `prefix + r` — Reload config
- `prefix + x` — Kill pane (no confirmation)
- `prefix + !` — Kill all sessions except current

## Helix

Config: `helix/config.toml`

- `install.sh` symlinks `helix/` → `~/.config/helix`

## Ghostty

Config: `ghostty/config`

- `install.sh` adds `config-file = <path>` to `~/.config/ghostty/config.ghostty` (idempotent)
- Settings here are merged into whatever exists in `config.ghostty`
