# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal Neovim configuration (Lua), plugin-managed by `lazy.nvim`.

## Structure

- `init.lua` — entry point. Bootstraps `lazy.nvim` via `require("config.lazy")`, then sets all core `vim.opt`/`vim.keymap` options and global keymaps directly (not in a separate options/keymaps module).
- `lua/config/lazy.lua` — bootstraps `lazy.nvim` itself (clones it if missing) and points lazy's plugin spec at `{ import = "config.plugins" }`.
- `lua/config/plugins/*.lua` — one file per plugin (or tightly related group of plugins), each returning a lazy.nvim plugin spec table. This is the only place plugins are declared; **adding a plugin means creating a new file here**, not editing a central list.
- `lazy-lock.json` — lockfile generated/maintained by lazy.nvim; don't hand-edit.

## Conventions for plugin files

- Each file in `lua/config/plugins/` returns either a single spec table or a list of spec tables (`return { { ... } }`), following lazy.nvim's spec format.
- Plugin-specific keymaps are set inside that plugin's own `config = function() ... end`, not in `init.lua`. `init.lua` only holds editor-wide/global keymaps and options that aren't tied to a specific plugin.
- LSP servers are configured in `lua/config/plugins/lsp.lua` via `nvim-lspconfig`, using `blink.cmp` for capabilities (completion is `saghen/blink.cmp`, configured in `completition.lua`). Mason (`mason.lua`) is present but currently has no `ensure_installed`/auto-install wiring — installing new LSP servers/tools currently must be done manually via `:Mason` or by extending `mason.lua`.
- LSP keymaps and the `BufWritePre` Lua auto-format-on-save are set inside the `LspAttach` autocmd in `lsp.lua` — add new per-buffer LSP behavior there, not in `init.lua`.
- Treesitter parsers to install are listed explicitly in `treesitter.lua`'s `ensure_installed` (`auto_install = false`); add new languages there.
- Theme is `cyberdream.nvim` (`theme.lua`), set with `transparent = true`. That file also still carries an unused `nvim-cmp` spec and a commented-out `kanagawa` colorscheme alternative — leave as-is unless asked to clean up.

## No build/lint/test tooling

There is no build step, linter, or test suite in this repo — it's a config, not a library. Validate changes by opening Neovim and checking for startup errors / exercising the relevant keymap or plugin, e.g.:

```sh
nvim --headless "+Lazy! sync" +qa   # sync/update plugins headlessly
nvim --headless -c 'lua print(vim.inspect(vim.opt.tabstop:get()))' +qa  # sanity-check a setting
```

## Misc

- Leader key is `<Space>` (`vim.g.mapleader`, set in both `init.lua` and `lazy.lua`).
- `readme.md` just lists two external prerequisites: Zig (`winget install Zig.Zig`) and `ripgrep`.
