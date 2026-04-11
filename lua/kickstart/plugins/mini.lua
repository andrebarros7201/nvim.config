return {
  { -- Collection of various small independent plugins/modules
    'nvim-mini/mini.nvim',
    config = function()
      -- Colorscheme
      require('mini.base16').setup {
        palette = {
          base00 = '#100F0F',
          base01 = '#1C1B1A',
          base02 = '#282726',
          base03 = '#4A4845',
          base04 = '#403E3C',
          base05 = '#878580',
          base06 = '#CECDC3',
          base07 = '#FFFCF0',
          base08 = '#AF3029', -- red
          base09 = '#BC5215', -- orange
          base0A = '#AD8301', -- yellow
          base0B = '#66800B', -- green
          base0C = '#24837B', -- cyan
          base0D = '#205EA6', -- blue
          base0E = '#5E409D', -- purple
          base0F = '#924D25', -- brown
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
        vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormal', { fg = '#FFFCF0', bg = '#66800B', bold = true }),
        vim.api.nvim_set_hl(0, 'MiniStatuslineModeInsert', { fg = '#FFFCF0', bg = '#24837B', bold = true }),
        vim.api.nvim_set_hl(0, 'MiniStatuslineModeVisual', { fg = '#FFFCF0', bg = '#BC5215', bold = true }),
        vim.api.nvim_set_hl(0, 'MiniStatuslineModeReplace', { fg = '#FFFCF0', bg = '#AF3029', bold = true }),
        vim.api.nvim_set_hl(0, 'MiniStatuslineModeCommand', { fg = '#FFFCF0', bg = '#AD8301', bold = true }),
        vim.api.nvim_set_hl(0, 'MiniStatuslineFilename', { fg = '#CECDC3', bg = '#1C1B1A' }),
        vim.api.nvim_set_hl(0, 'MiniStatuslineDevinfo', { fg = '#878580', bg = '#1C1B1A' }),
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
      -- Diagnostics
      require('mini.pick').setup()
      require('mini.extra').setup()
      vim.keymap.set('n', '<leader>da', function() require('mini.extra').pickers.diagnostic() end, { desc = 'Diagnostics' })
      vim.keymap.set('n', '<leader>d', function() require('mini.extra').pickers.diagnostic { scope = 'current' } end, { desc = 'Current buffer diagnostics' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
