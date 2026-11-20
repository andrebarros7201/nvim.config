-- Neovim configuration entry point.
-- Core settings live in lua/config/, plugin specs in lua/plugins/.

-- Leader keys must be set before any keymaps or plugins are defined
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- A Nerd Font is installed and selected in the terminal (enables icons)
vim.g.have_nerd_font = true

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.lazy'
