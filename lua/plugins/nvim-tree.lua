-- nvim-tree.lua: file explorer in a side panel

-- When Neovim is opened on a directory (`nvim .`), nvim-tree must load at startup
-- so it can take over that buffer; otherwise it loads on first use.
local opened_on_directory = vim.fn.argc(-1) == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1

---@module 'lazy'
---@type LazySpec
return {
  'nvim-tree/nvim-tree.lua',
  lazy = not opened_on_directory,
  cmd = { 'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeFocus', 'NvimTreeFindFile' },
  keys = {
    { '<leader>e', '<cmd>NvimTreeToggle<CR>', mode = { 'n', 'v' }, desc = 'Toggle file tree' },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  init = function()
    -- nvim-tree replaces netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  opts = {
    sort = { sorter = 'case_sensitive' },
    view = { width = 30, side = 'right' },
    renderer = { group_empty = true },
    filters = { dotfiles = false },
  },
}
