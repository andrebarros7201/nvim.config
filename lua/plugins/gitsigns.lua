-- gitsigns.nvim: git change signs, hunk actions and blame
---@module 'lazy'
---@type LazySpec
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  ---@module 'gitsigns'
  ---@type Gitsigns.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    signs = {
      add = { text = '+' }, ---@diagnostic disable-line: missing-fields
      change = { text = '~' }, ---@diagnostic disable-line: missing-fields
      delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
      topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
      changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
    },
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      local function map(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = 'Git: ' .. desc }) end

      -- Navigation (falls back to the built-in ]c / [c in diff mode)
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, 'next change')
      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, 'previous change')

      -- Hunks
      map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'stage selected lines')
      map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'reset selected lines')
      map('n', '<leader>hs', gitsigns.stage_hunk, 'stage hunk')
      map('n', '<leader>hr', gitsigns.reset_hunk, 'reset hunk')
      map('n', '<leader>hu', gitsigns.stage_hunk, 'undo stage hunk')
      map('n', '<leader>hS', gitsigns.stage_buffer, 'stage buffer')
      map('n', '<leader>hR', gitsigns.reset_buffer, 'reset buffer')
      map('n', '<leader>hp', gitsigns.preview_hunk, 'preview hunk')
      map('n', '<leader>hb', gitsigns.blame_line, 'blame line')
      map('n', '<leader>hd', gitsigns.diffthis, 'diff against index')
      map('n', '<leader>hD', function() gitsigns.diffthis '@' end, 'diff against last commit')

      -- Toggles
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, 'toggle line blame')
      map('n', '<leader>td', gitsigns.preview_hunk_inline, 'show deleted lines')
    end,
  },
}
