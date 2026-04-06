return {
	{ -- Collection of various small independent plugins/modules
		"nvim-mini/mini.nvim",
		config = function()
			-- Colorscheme
			require("mini.base16").setup({
				palette = {
					base00 = "#100f0f", -- background
					base01 = "#1c1b1a", -- lighter bg
					base02 = "#2c2b29", -- selection
					base03 = "#45423e", -- comments
					base04 = "#6f6b66", -- dark fg
					base05 = "#cecac3", -- main text
					base06 = "#e5e0d7", -- light fg
					base07 = "#f2f0ec", -- light bg
					base08 = "#af3029", -- red (errors)
					base09 = "#bc5215", -- orange (keywords)
					base0A = "#c0760b", -- yellow (constants)
					base0B = "#66800b", -- green (strings)
					base0C = "#24837b", -- cyan (specials)
					base0D = "#205ea6", -- blue (functions)
					base0E = "#8f3f71", -- magenta (types)
					base0F = "#823e00", -- brown (misc)
				},
				use_cterm = true,
				plugins = {
					default = true,
					["nvim-mini/mini.nvim"] = true,
				},
			})

			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			-- Simple and easy statusline.
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({
				use_icons = vim.g.have_nerd_font,
				vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { fg = "#000000", bg = "#a9dc76", bold = true }),
				vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { fg = "#000000", bg = "#78dce8", bold = true }),
				vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual", { fg = "#000000", bg = "#fc9867", bold = true }),
				vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { fg = "#000000", bg = "#ff6188", bold = true }),
				vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { fg = "#000000", bg = "#ffd866", bold = true }),
				vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { fg = "#ffffff", bg = "#1c1c1c" }),
				vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { fg = "#888888", bg = "#1c1c1c" }),
			})
			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			-- Starter screen
			require("mini.starter").setup()
			-- Show Scope indent
			require("mini.indentscope").setup({
				draw = { animation = require("mini.indentscope").gen_animation.none() },
			})
			-- Auto pairs
			require("mini.pairs").setup()
			-- Colorizer
			require("mini.hipatterns").setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
				},
			})
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
