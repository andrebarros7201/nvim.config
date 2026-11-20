-- blink.cmp: completion menu with LSP, path, snippet and buffer sources
---@module 'lazy'
---@type LazySpec
return {
  'saghen/blink.cmp',
  version = '1.*', -- release builds ship a prebuilt Rust fuzzy matcher
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      -- jsregexp (for advanced snippet transforms) needs `make`; skipped on Windows
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
        return 'make install_jsregexp'
      end)(),
    },
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'default',
      ['<CR>'] = { 'select_and_accept', 'fallback' },
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    },
    appearance = { nerd_font_variant = 'mono' },
    completion = {
      menu = { border = 'single' },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 300,
        window = { border = 'single' },
      },
    },
    signature = {
      enabled = true,
      window = { border = 'single' },
    },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
    snippets = { preset = 'luasnip' },
    -- Fall back to the Lua matcher (with a warning) if the Rust binary can't load
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
}
