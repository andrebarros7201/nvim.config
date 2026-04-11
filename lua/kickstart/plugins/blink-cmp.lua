---@module 'lazy'
---@type LazySpec
return {
  {
    -- Modern completion engine (faster alternative to nvim-cmp)
    'saghen/blink.cmp',

    event = 'VimEnter',
    version = '1.*',

    dependencies = {
      {
        -- Snippet engine
        'L3MON4D3/LuaSnip',
        version = '2.*',

        -- Optional build step for regex support in snippets
        build = (function()
          -- Skip on Windows or if `make` is unavailable
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
          return 'make install_jsregexp'
        end)(),
      },
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- Key mappings
      keymap = {
        preset = 'default',
        -- Accept completion
        ['<CR>'] = { 'select_and_accept', 'fallback' },

        -- Trigger completion / docs
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      },

      -- UI tweaks (for Nerd Fonts)
      appearance = {
        nerd_font_variant = 'mono',
      },

      -- Completion behavior
      completion = {
        documentation = {
          auto_show = true, -- show docs automatically
          auto_show_delay_ms = 300, -- slight delay for readability
        },
      },

      -- Completion sources
      sources = {
        default = {
          'lsp', -- LSP suggestions (main source)
          'path', -- file paths
          'snippets', -- LuaSnip
          'buffer', -- words from current file
        },
      },

      -- Snippet engine integration
      snippets = {
        preset = 'luasnip',
      },

      -- Fuzzy matching algorithm
      fuzzy = {
        implementation = 'lua', -- can switch to 'rust' for more performance
      },

      -- Show function signature
      signature = {
        enabled = true,
      },
    },
  },
}
