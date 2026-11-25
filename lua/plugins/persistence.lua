-- persistence.nvim: save a session per directory and git branch on exit, restore it on demand
---@module 'lazy'
---@type LazySpec
return {
  'folke/persistence.nvim',
  -- Start recording only once a file is opened, so quitting from the start screen
  -- never overwrites a saved session
  event = 'BufReadPre',
  keys = {
    { '<leader>wr', function() require('persistence').load() end, desc = 'Session: restore for this directory' },
    { '<leader>wl', function() require('persistence').load { last = true } end, desc = 'Session: restore last' },
    { '<leader>ws', function() require('persistence').select() end, desc = 'Session: select' },
    { '<leader>wd', function() require('persistence').stop() end, desc = "Session: don't save on exit" },
  },
  init = function()
    -- What a session stores (leaves out empty windows and terminals)
    vim.o.sessionoptions = 'buffers,curdir,folds,help,tabpages,winsize'

    -- Side panels don't restore cleanly, so close them before the session is saved
    vim.api.nvim_create_autocmd('User', {
      group = vim.api.nvim_create_augroup('persistence-close-panels', { clear = true }),
      pattern = 'PersistenceSavePre',
      callback = function()
        if package.loaded['nvim-tree'] then require('nvim-tree.api').tree.close_in_all_tabs() end
        if package.loaded['trouble'] then pcall(require('trouble').close) end
      end,
    })
  end,
  opts = {},
}
