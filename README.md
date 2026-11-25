# nvim.config

My Neovim configuration, built on [lazy.nvim](https://github.com/folke/lazy.nvim). It's set up for
web development (TypeScript, React, Angular, Tailwind), C/C++, Rust and Lua, with a pure-black
Flexoki color palette.

Most plugins load on demand, so Neovim opens to the start screen with only the colorscheme,
statusline and treesitter loaded.

## Requirements

| Tool | Used for |
|---|---|
| [Neovim](https://github.com/neovim/neovim/releases) 0.11 or newer (developed on 0.12) | |
| Git | installing plugins |
| `make` and a C compiler (gcc, clang or zig) | building telescope-fzf-native and treesitter parsers |
| [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/tree/master/crates/cli) | installing treesitter parsers |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Telescope live grep |
| Node.js and npm | Node-based language servers and prettierd |
| A [Nerd Font](https://www.nerdfonts.com/), selected in your terminal | icons |
| Rust toolchain via [rustup](https://rustup.rs/) (optional) | rustfmt and clippy |

Run `:checkhealth config` inside Neovim to check all of these.

## Install

Back up any existing config first, then clone this repo into Neovim's config folder.

Windows (PowerShell):

```powershell
git clone https://github.com/andrebarros7201/nvim.config.git "$env:LOCALAPPDATA\nvim"
```

Linux and macOS:

```sh
git clone https://github.com/andrebarros7201/nvim.config.git ~/.config/nvim
```

Start `nvim`. On the first launch:

- lazy.nvim installs the plugins at the versions pinned in `lazy-lock.json`.
- Treesitter installs its parsers.
- Opening the first file makes Mason install the language servers and formatters.

## Layout

```
init.lua              leader keys, then loads lua/config/
lua/config/
  options.lua         editor options and diagnostic display
  keymaps.lua         core keymaps
  autocmds.lua        editor-wide autocommands
  lazy.lua            lazy.nvim bootstrap and settings
  health.lua          :checkhealth config
lua/plugins/          one file per plugin, imported automatically by lazy.nvim
```

To add a plugin, create a new file in `lua/plugins/` that returns a lazy.nvim spec.

## Languages

| Language | Language server | Formatter |
|---|---|---|
| TypeScript, JavaScript, React | ts_ls | prettierd |
| HTML, CSS, SCSS | html, cssls, emmet_language_server | prettierd (CSS, SCSS) |
| Tailwind CSS | tailwindcss | |
| Angular | angularls | |
| C, C++ | clangd | clang-format (uses `.clang-format`, else LLVM style) |
| Rust | rust_analyzer (clippy on save) | rustfmt |
| Lua | lua_ls | stylua |
| JSON | | prettierd |

Files are formatted on save. Filetypes without a formatter fall back to the language server's
formatter.

## Plugins

| Plugin | Purpose |
|---|---|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | plugin manager |
| [mini.nvim](https://github.com/nvim-mini/mini.nvim) | colorscheme, statusline, start screen, text objects, surround, auto-pairs, indent scope, hex color preview |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | syntax highlighting and indentation |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), [mason.nvim](https://github.com/mason-org/mason.nvim), [mason-tool-installer](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | language servers and their installation |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | language server progress messages |
| [blink.cmp](https://github.com/saghen/blink.cmp), [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | completion and snippets |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | format on save |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | git change signs, hunk staging and blame |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | fuzzy finder |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | file explorer |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | diagnostics list |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | highlights TODO, FIXME and NOTE comments |
| [undotree](https://github.com/jiaoshijie/undotree) | undo history tree |
| [guess-indent.nvim](https://github.com/NMAC427/guess-indent.nvim) | detects each file's indentation |
| [persistence.nvim](https://github.com/folke/persistence.nvim) | saves and restores sessions |

## Keymaps

The leader key is <kbd>Space</kbd>.

### General

| Keys | Mode | Action |
|---|---|---|
| `<Esc>` | normal | clear search highlight |
| `<leader>q` | normal | diagnostics to location list |
| `<Esc><Esc>` | terminal | exit terminal mode |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | normal | focus window left / down / up / right |
| `<C-S-h>` `<C-S-j>` `<C-S-k>` `<C-S-l>` | normal | move window left / down / up / right |
| `<leader>s` / `<leader>v` | normal | split horizontally / vertically |
| `<C-d>` / `<C-u>` | normal | scroll half a page, cursor centered |
| `J` / `K` | visual | move selected lines down / up |
| `<leader>kc` | normal, visual | toggle comment |
| `<leader>e` | normal, visual | toggle file tree |
| `<leader>u` | normal | toggle undo tree |
| `<leader>cf` | normal | format file |

The arrow keys print a reminder to use `h` `j` `k` `l`.

### Search (Telescope)

| Keys | Action |
|---|---|
| `<leader>ff` | find files |
| `<leader>fg` | grep in project |
| `<leader>fs` | list Telescope pickers |
| `<leader><leader>` | open buffers |
| `<leader>sw` | search word under cursor |
| `<leader>ss` | document symbols |
| `<leader>sd` | diagnostics |
| `<leader>sf` | search in current buffer |
| `<leader>so` | grep in open files |
| `<leader>sn` | find files in this config |

### Code (when a language server is attached)

| Keys | Mode | Action |
|---|---|---|
| `K` | normal | hover documentation |
| `<leader>gd` | normal | go to definition |
| `<leader>gr` | normal | go to references |
| `<leader>gi` | normal | go to implementation |
| `<leader>rn` | normal | rename symbol |
| `<leader>ca` | normal, visual | code action |
| `<leader>th` | normal | toggle inlay hints |
| `<leader>d` | normal | diagnostics for this buffer (Trouble) |
| `<leader>da` | normal | diagnostics for the workspace (Trouble) |

### Completion (insert mode)

| Keys | Action |
|---|---|
| `<CR>` or `<C-y>` | accept |
| `<C-n>` / `<C-p>` | next / previous item |
| `<C-space>` | open menu, toggle documentation |
| `<C-e>` | close menu |
| `<C-b>` / `<C-f>` | scroll documentation |
| `<Tab>` / `<S-Tab>` | jump to next / previous snippet field |
| `<C-k>` | toggle signature help |

### Git (in files tracked by git)

| Keys | Mode | Action |
|---|---|---|
| `]c` / `[c` | normal | next / previous change |
| `<leader>hs` | normal, visual | stage hunk or selected lines |
| `<leader>hr` | normal, visual | reset hunk or selected lines |
| `<leader>hu` | normal | undo stage hunk |
| `<leader>hS` / `<leader>hR` | normal | stage / reset buffer |
| `<leader>hp` | normal | preview hunk |
| `<leader>hb` | normal | blame line |
| `<leader>hd` / `<leader>hD` | normal | diff against index / last commit |
| `<leader>tb` | normal | toggle line blame |
| `<leader>td` | normal | show deleted lines |

### Sessions

When you quit, the open files and window layout are saved as a session for the current directory
(one per git branch). Quitting from the start screen without opening a file doesn't overwrite it.
Restore a session from the start screen's **Restore session** item or with these keys:

| Keys | Action |
|---|---|
| `<leader>wr` | restore the session for this directory |
| `<leader>wl` | restore the last session, from any directory |
| `<leader>ws` | pick a saved session |
| `<leader>wd` | don't save a session when quitting this time |

### Editing (mini.nvim)

| Keys | Action |
|---|---|
| `sa` / `sd` / `sr` | add / delete / replace surrounding, e.g. `saiw)` |
| `a` / `i` text objects | extra text objects, e.g. `va)`, `ci'`, `yinq` |

## Credits

Started from [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim), a
multi-file version of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). Licensed
under the MIT license; see [LICENSE.md](LICENSE.md).
