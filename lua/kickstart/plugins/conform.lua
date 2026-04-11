---@module 'lazy'
---@type LazySpec
return {
  'stevearc/conform.nvim',
  -- Lazy.nvim opts (not used here since we configure manually below)
  opts = {},

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
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        scss = { 'prettier' },
        css = { 'prettier' },
        json = { 'prettier' },
      },

      -- Custom formatter configurations
      formatters = {
        ['clang-format'] = {
          -- Use project config file if available (.clang-format)
          -- Otherwise fallback to LLVM style
          prepend_args = { '-style=file', '-fallback-style=LLVM' },
        },

        -- Override prettier command resolution
        prettier = {
          command = function(_, ctx)
            -- Prefer project-local prettier (node_modules)
            local local_bin = ctx.dirname .. '/node_modules/.bin/prettier'

            -- Use local version if it exists, otherwise fallback to global
            return vim.fn.executable(local_bin) == 1 and local_bin or 'prettier'
          end,
        },
      },
    }

    -- Manual format keymap
    vim.keymap.set('n', '<leader>cf', function() require('conform').format { bufnr = 0 } end, { desc = 'Format current file' })
  end,
}
