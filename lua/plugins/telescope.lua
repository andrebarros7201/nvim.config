-- telescope.nvim: fuzzy finder for files, text, buffers, symbols and diagnostics

---Returns a function that opens a Telescope builtin picker.
---@param name string
---@param opts? table
local function pick(name, opts)
  return function() require('telescope.builtin')[name](opts and vim.deepcopy(opts)) end
end

---@module 'lazy'
---@type LazySpec
return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function() return vim.fn.executable 'make' == 1 end,
    },
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>ff', pick 'find_files', desc = 'Find files' },
    { '<leader>fg', pick 'live_grep', desc = 'Find by grep' },
    { '<leader>fs', pick 'builtin', desc = 'Find Telescope picker' },
    { '<leader><leader>', pick 'buffers', desc = 'Find open buffers' },
    { '<leader>sw', pick 'grep_string', desc = 'Search current word' },
    { '<leader>ss', pick 'lsp_document_symbols', desc = 'Search document symbols' },
    { '<leader>sd', pick 'diagnostics', desc = 'Search diagnostics' },
    {
      '<leader>sf',
      function()
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      desc = 'Search in current buffer',
    },
    {
      '<leader>so',
      pick('live_grep', { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }),
      desc = 'Search in open files',
    },
    { '<leader>sn', pick('find_files', { cwd = vim.fn.stdpath 'config' }), desc = 'Search Neovim config' },
  },
  init = function()
    -- Load Telescope the first time a selection menu opens (e.g. code actions), so the
    -- ui-select picker is used even before Telescope has been opened another way.
    local original_select = vim.ui.select
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      vim.ui.select = original_select
      require('lazy').load { plugins = { 'telescope.nvim' } }
      return vim.ui.select(...)
    end
  end,
  config = function()
    local telescope = require 'telescope'
    telescope.setup {
      defaults = {
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        layout_config = {
          prompt_position = 'top',
          width = 0.85,
          height = 0.85,
          preview_cutoff = 120,
        },
        sorting_strategy = 'ascending',
      },
      extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown() },
      },
    }
    -- Both extensions are optional (fzf-native needs `make` to build)
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'ui-select')
  end,
}
