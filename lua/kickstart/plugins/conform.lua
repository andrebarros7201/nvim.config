return {
  'stevearc/conform.nvim',
  opts = {},
  config = function()
    require('conform').setup {
      format_on_save = {
        timeout_ms = 5000,
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        c = { 'clang-format' },
        cpp = { 'clang-format' },
        lua = { 'stylua' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
      },
      formatters = {
        ['clang-format'] = {
          prepend_args = { '-style=file', '-fallback-style=LLVM' },
          prettier = {
            command = function(_, ctx)
              local local_bin = ctx.dirname .. '/node_modules/.bin/prettier'
              return vim.fn.executable(local_bin) == 1 and local_bin or 'prettier'
            end,
          },
        },
      },
    }

    vim.keymap.set('n', '<leader>cf', function() require('conform').format { bufnr = 0 } end)
  end,
}
