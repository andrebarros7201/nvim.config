-- undotree: browse and restore the undo history as a tree
---@module 'lazy'
---@type LazySpec
return {
  'jiaoshijie/undotree',
  keys = {
    { '<leader>u', function() require('undotree').toggle() end, desc = 'Toggle undo tree' },
  },
  opts = {},
}
