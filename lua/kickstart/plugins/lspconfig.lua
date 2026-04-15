---@module 'lazy'
---@type LazySpec
return {
  {
    -- Core LSP plugin
    'neovim/nvim-lspconfig',

    dependencies = {
      -- LSP installer (manages external binaries)
      { 'mason-org/mason.nvim', opts = {} },

      -- Bridge between Mason and lspconfig
      'mason-org/mason-lspconfig.nvim',

      -- Automatically installs tools (LSPs, formatters, etc.)
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- LSP status UI (loading, indexing, etc.)
      { 'j-hui/fidget.nvim', opts = {} },

      -- Formatter plugin (separate from LSP!)
      'stevearc/conform.nvim',
    },

    config = function()
      -- Override the floating preview function globally
      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = 'single'
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      -- Extend LSP capabilities so completion (blink.cmp) works fully
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Runs whenever an LSP attaches to a buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          -- Helper to define buffer-local keymaps
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, {
              buffer = event.buf,
              desc = 'LSP: ' .. desc,
            })
          end

          -- Navigation
          map('<leader>gd', vim.lsp.buf.definition, 'Goto Definition')
          map('<leader>gr', vim.lsp.buf.references, 'Goto References')
          map('<leader>gi', vim.lsp.buf.implementation, 'Goto Implementation')

          -- Info
          map('K', vim.lsp.buf.hover, 'Hover Docs')

          -- Refactoring
          map('<leader>rn', vim.lsp.buf.rename, 'Rename')
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })

          -- Highlight symbol references under cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method 'textDocument/documentHighlight' then
            local group = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = group,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = group,
              callback = vim.lsp.buf.clear_references,
            })
          end

          -- Toggle inlay hints (if supported by server)
          if client and client:supports_method 'textDocument/inlayHint' then
            map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, 'Toggle Inlay Hints')
          end
        end,
      })

      -- Define language servers
      local servers = {
        -- TypeScript / JavaScript
        ts_ls = {
          settings = {
            typescript = {
              format = { enable = false }, -- Disable LSP formatting (use prettier instead)
            },
            javascript = {
              format = { enable = false },
            },
          },
        },

        -- Lua (for Neovim config)
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },

              -- Tell LSP that `vim` is a global
              diagnostics = { globals = { 'vim' } },

              workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file('', true),
              },

              -- Disable formatting (handled by conform)
              format = { enable = false },
            },
          },
        },

        -- C / C++
        clangd = {},

        -- CSS
        cssls = {},

        -- TailwindCSS
        tailwindcss = {
          filetypes = {
            'html',
            'css',
            'scss',
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
          },
        },

        -- HTML
        html = {},
      }

      -- Ensure all servers are installed via Mason
      local ensure_installed = vim.tbl_keys(servers)

      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed,
      }

      -- Setup each server
      for name, server in pairs(servers) do
        server.capabilities = capabilities -- Attach completion capabilities
        vim.lsp.config(name, server)
        vim.lsp.enable(name)
      end

      -- Formatting setup (Conform)
      require('conform').setup {
        formatters_by_ft = {
          lua = { 'stylua' },
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          javascriptreact = { 'prettier' },
          typescriptreact = { 'prettier' },
          scss = { 'prettier' },
          css = { 'prettier' },
          json = { 'prettier' },
        },
      }

      -- Autoformat on save
      vim.api.nvim_create_autocmd('BufWritePre', {
        callback = function(args) require('conform').format { bufnr = args.buf } end,
      })
    end,
  },
}
