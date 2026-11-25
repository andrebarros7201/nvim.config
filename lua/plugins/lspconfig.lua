-- nvim-lspconfig: language servers, installed and kept up to date by Mason
---@module 'lazy'
---@type LazySpec
return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'mason-org/mason.nvim', cmd = 'Mason', opts = { ui = { border = 'single' } } },
    'mason-org/mason-lspconfig.nvim', -- maps lspconfig server names to Mason package names
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} }, -- LSP progress messages
    'saghen/blink.cmp',
  },
  config = function()
    -- Give LSP floating windows a border unless the caller asked for one
    local open_floating_preview = vim.lsp.util.open_floating_preview
    ---@diagnostic disable-next-line: duplicate-set-field
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or 'single'
      return open_floating_preview(contents, syntax, opts, ...)
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local function map(keys, func, desc, mode) vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc }) end

        -- Hover (`K`) is a built-in default since Neovim 0.11
        map('<leader>gd', vim.lsp.buf.definition, 'Goto definition')
        map('<leader>gr', vim.lsp.buf.references, 'Goto references')
        map('<leader>gi', vim.lsp.buf.implementation, 'Goto implementation')
        map('<leader>rn', vim.lsp.buf.rename, 'Rename')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code action', { 'n', 'x' })

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Highlight references to the symbol under the cursor
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
          -- Remove those autocmds when the server detaches (e.g. :LspRestart)
          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(detach)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = detach.buf }
            end,
          })
        end

        if client and client:supports_method 'textDocument/inlayHint' then
          map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, 'Toggle inlay hints')
        end
      end,
    })

    -- Server-specific settings. Formatting is done by conform.nvim, not the servers.
    local servers = {
      ts_ls = {
        settings = {
          typescript = { format = { enable = false } },
          javascript = { format = { enable = false } },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            format = { enable = false },
          },
        },
      },
      clangd = {},
      cssls = {},
      html = {},
      tailwindcss = {
        filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
      },
      emmet_language_server = {
        filetypes = { 'css', 'html', 'javascriptreact', 'less', 'sass', 'scss', 'typescriptreact' },
      },
      angularls = {},
      rust_analyzer = {
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = true,
            check = { command = 'clippy' },
          },
        },
      },
    }

    -- Install every server plus the formatters conform uses (rustfmt ships with rustup)
    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, { 'stylua', 'prettierd', 'clang-format' })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    local capabilities = require('blink.cmp').get_lsp_capabilities()
    for name, server in pairs(servers) do
      server.capabilities = capabilities
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
}
