-- Bootstrap lazy.nvim and load every plugin spec in lua/plugins/
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local repo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', repo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  spec = { { import = 'plugins' } },
  change_detection = { notify = false },
  -- No plugin here needs luarocks; disabling it avoids hererocks warnings
  rocks = { enabled = false },
  ui = { border = 'single' },
  performance = {
    rtp = {
      -- Built-in plugins this config never uses (netrw is disabled by nvim-tree)
      disabled_plugins = { 'gzip', 'tarPlugin', 'tohtml', 'tutor', 'zipPlugin' },
    },
  },
}
