---@module 'lazy'
---@type LazySpec
return {
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'Trouble',
    keys = {
      { '<leader>da', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Trouble: workspace diagnostics' },
      { '<leader>d', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Trouble: buffer diagnostics' },
    },
    opts = {},
  },
}
