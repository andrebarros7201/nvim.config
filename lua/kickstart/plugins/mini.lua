return {
  { -- Collection of various small independent plugins/modules
    'nvim-mini/mini.nvim',
    config = function()
      -- Colorscheme
      require('mini.base16').setup {
        palette = {
          base00 = '#0d0f0e', -- background
          base01 = '#191c1b', -- lighter bg
          base02 = '#282c2a', -- selection
          base03 = '#404744', -- comments
          base04 = '#686f6b', -- dark fg
          base05 = '#c4ccc7', -- main text
          base06 = '#dde4df', -- light fg
          base07 = '#edf2ee', -- light bg
          base08 = '#b03535', -- red (errors)
          base09 = '#a05028', -- orange (keywords)
          base0A = '#8a7820', -- ochre (constants)
          base0B = '#3a7835', -- forest (strings)
          base0C = '#1a7878', -- slate teal (specials)
          base0D = '#2a5aa0', -- deep blue (functions)
          base0E = '#784080', -- plum (types)
          base0F = '#6e4025', -- umber (misc)
        },
        use_cterm = true,
        plugins = {
          default = true,
          ['nvim-mini/mini.nvim'] = true,
        },
      }

      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup {
        use_icons = vim.g.have_nerd_font,
        vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormal', { fg = '#edf2ee', bg = '#3a7835', bold = true }),
        vim.api.nvim_set_hl(0, 'MiniStatuslineModeInsert', { fg = '#edf2ee', bg = '#1a7878', bold = true }),
        vim.api.nvim_set_hl(0, 'MiniStatuslineModeVisual', { fg = '#edf2ee', bg = '#a05028', bold = true }),
        vim.api.nvim_set_hl(0, 'MiniStatuslineModeReplace', { fg = '#edf2ee', bg = '#b03535', bold = true }),
        vim.api.nvim_set_hl(0, 'MiniStatuslineModeCommand', { fg = '#edf2ee', bg = '#8a7820', bold = true }),
        vim.api.nvim_set_hl(0, 'MiniStatuslineFilename', { fg = '#c4ccc7', bg = '#191c1b' }),
        vim.api.nvim_set_hl(0, 'MiniStatuslineDevinfo', { fg = '#686f6b', bg = '#191c1b' }),
      }
      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function() return '%2l:%-2v' end

      -- Starter screen
      require('mini.starter').setup()
      -- Show Scope indent
      require('mini.indentscope').setup {
        draw = { animation = require('mini.indentscope').gen_animation.none() },
      }
      -- Auto pairs
      require('mini.pairs').setup()
      -- Colorizer
      require('mini.hipatterns').setup {
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
        },
      }
      -- Needed for diagnostics
      require('mini.pick').setup()
      require('mini.extra').setup()
      vim.keymap.set('n', '<leader>d', function() require('mini.extra').pickers.diagnostic() end, { desc = 'Diagnostics picker' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
