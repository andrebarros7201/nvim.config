-- trouble.nvim: list of diagnostics for the current buffer or the whole workspace
---@module 'lazy'
---@type LazySpec
return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>d', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Trouble: buffer diagnostics' },
    { '<leader>da', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Trouble: workspace diagnostics' },
  },
  opts = {},
}
