---@module 'lazy'
---@type LazySpec
return {
  'stevearc/conform.nvim',

  config = function()
    require('conform').setup {

      -- Automatically format on save
      format_on_save = {
        timeout_ms = 5000, -- Max time allowed for formatting before aborting
        lsp_format = 'fallback',
        -- If no formatter is configured for a filetype,
        -- fallback to LSP formatting (if available)
      },

      -- Map filetypes to formatters
      formatters_by_ft = {
        c = { 'clang-format' },
        cpp = { 'clang-format' },
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        scss = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        rust = { 'rustfmt' },
      },

      -- Custom formatter configurations
      formatters = {
        ['clang-format'] = {
          -- Use project config file if available (.clang-format)
          -- Otherwise fallback to LLVM style
          prepend_args = { '-style=file', '-fallback-style=LLVM' },
        },
      },
    }

    -- Manual format keymap
    vim.keymap.set('n', '<leader>cf', function() require('conform').format { bufnr = 0 } end, { desc = 'Format current file' })
  end,
}
