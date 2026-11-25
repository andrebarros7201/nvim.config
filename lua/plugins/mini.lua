-- mini.nvim: colorscheme, statusline, start screen and small editing modules
---@module 'lazy'
---@type LazySpec
return {
  'nvim-mini/mini.nvim',
  lazy = false,
  priority = 1000, -- provides the colorscheme, so it loads before everything else
  config = function()
    -- Colorscheme: Flexoki-based base16 palette on a pure black background
    require('mini.base16').setup {
      palette = {
        base00 = '#000000',
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

    -- Statusline, with mode colors from the palette's accents
    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function() return '%2l:%-2v' end -- LINE:COLUMN

    local set_hl = vim.api.nvim_set_hl
    set_hl(0, 'MiniStatuslineModeNormal', { fg = '#FFFCF0', bg = '#66800B', bold = true })
    set_hl(0, 'MiniStatuslineModeInsert', { fg = '#FFFCF0', bg = '#24837B', bold = true })
    set_hl(0, 'MiniStatuslineModeVisual', { fg = '#FFFCF0', bg = '#BC5215', bold = true })
    set_hl(0, 'MiniStatuslineModeReplace', { fg = '#FFFCF0', bg = '#AF3029', bold = true })
    set_hl(0, 'MiniStatuslineModeCommand', { fg = '#FFFCF0', bg = '#AD8301', bold = true })
    set_hl(0, 'MiniStatuslineFilename', { fg = '#CECDC3', bg = '#1C1B1A' })
    set_hl(0, 'MiniStatuslineDevinfo', { fg = '#878580', bg = '#1C1B1A' })

    -- Start screen. Type an item's first letters to select it.
    local starter = require 'mini.starter'
    starter.setup {
      evaluate_single = true,
      header = table.concat({
        '███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
        '████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
        '██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
        '██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
        '██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
        '╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
      }, '\n'),
      items = {
        { section = 'Actions', name = 'Find file', action = 'Telescope find_files' },
        { section = 'Actions', name = 'Restore session', action = function() require('persistence').load() end },
        { section = 'Actions', name = 'Recent files', action = 'Telescope oldfiles' },
        { section = 'Actions', name = 'Grep text', action = 'Telescope live_grep' },
        {
          section = 'Actions',
          name = 'Config',
          action = function() require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' } end,
        },
        { section = 'Actions', name = 'Lazy', action = 'Lazy' },
        { section = 'Actions', name = 'Mason', action = 'Mason' },
        { section = 'Actions', name = 'Quit', action = 'qall' },
        starter.sections.recent_files(5, true),
      },
      footer = function()
        local stats = require('lazy').stats()
        local time = stats.startuptime > 0 and (' in %.0f ms'):format(stats.startuptime) or ''
        return ('Loaded %d of %d plugins%s'):format(stats.loaded, stats.count, time)
      end,
      content_hooks = {
        starter.gen_hook.adding_bullet '│ ',
        starter.gen_hook.aligning('center', 'center'),
      },
    }
    -- lazy.nvim measures startup time after the UI is up; redraw the footer then
    vim.api.nvim_create_autocmd('User', {
      group = vim.api.nvim_create_augroup('mini-starter-footer', { clear = true }),
      pattern = 'LazyVimStarted',
      once = true,
      callback = function()
        if vim.bo.filetype == 'ministarter' then starter.refresh() end
      end,
    })

    -- Editing
    require('mini.ai').setup { n_lines = 500 } -- extra text objects, e.g. `va)` or `ci'`
    require('mini.surround').setup() -- `sa` add, `sd` delete, `sr` replace surroundings
    require('mini.pairs').setup() -- auto-close brackets and quotes
    require('mini.hipatterns').setup {
      highlighters = {
        hex_color = require('mini.hipatterns').gen_highlighter.hex_color(), -- color `#rrggbb` text
      },
    }

    -- Indent scope guide, hidden in buffers that aren't files
    require('mini.indentscope').setup {
      draw = { animation = require('mini.indentscope').gen_animation.none() },
    }
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('mini-indentscope-disable', { clear = true }),
      pattern = { 'ministarter', 'help', 'checkhealth', 'lazy', 'mason', 'NvimTree', 'trouble' },
      callback = function() vim.b.miniindentscope_disable = true end,
    })
  end,
}
