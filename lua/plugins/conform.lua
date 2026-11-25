-- conform.nvim: format on save with external formatters
local prettier = { 'prettierd', 'prettier', stop_after_first = true }

---@module 'lazy'
---@type LazySpec
return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = 'ConformInfo',
  dependencies = { 'mason-org/mason.nvim' }, -- puts Mason-installed formatters on PATH
  keys = {
    { '<leader>cf', function() require('conform').format { bufnr = 0 } end, desc = 'Format current file' },
  },
  ---@module 'conform'
  ---@type conform.setupOpts
  opts = {
    -- Use the LSP formatter when no formatter is configured for the filetype
    format_on_save = { timeout_ms = 5000, lsp_format = 'fallback' },
    formatters_by_ft = {
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      lua = { 'stylua' },
      rust = { 'rustfmt' },
      javascript = prettier,
      typescript = prettier,
      javascriptreact = prettier,
      typescriptreact = prettier,
      css = prettier,
      scss = prettier,
      json = prettier,
    },
    formatters = {
      -- Use the project's .clang-format if there is one, otherwise LLVM style
      ['clang-format'] = { prepend_args = { '-style=file', '-fallback-style=LLVM' } },
    },
  },
}
