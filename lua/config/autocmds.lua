-- Editor-wide autocommands (plugin-specific ones live with their plugin spec)

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = vim.api.nvim_create_augroup('config-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
