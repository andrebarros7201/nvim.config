-- guess-indent.nvim: detect tabs vs spaces and indent width from each file's contents
---@module 'lazy'
---@type LazySpec
return {
  'NMAC427/guess-indent.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {},
}
