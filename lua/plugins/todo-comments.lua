-- todo-comments.nvim: highlight TODO, FIXME, HACK, NOTE and similar in comments
---@module 'lazy'
---@type LazySpec
return {
  'folke/todo-comments.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  ---@module 'todo-comments'
  ---@type TodoOptions
  ---@diagnostic disable-next-line: missing-fields
  opts = { signs = false },
}
