-- Editor options and diagnostic display
local o = vim.o
local opt = vim.opt

-- General behavior
o.confirm = true -- Ask to save before quitting unsaved changes
o.mouse = 'a' -- Enable mouse support in all modes
o.undofile = true -- Save undo history between sessions
o.scrolloff = 10 -- Keep 10 lines visible above/below cursor
o.updatetime = 250 -- Faster updates for plugins
o.timeoutlen = 300 -- Shorter timeout for mapped sequences
o.fileformats = 'unix,dos' -- New files use LF; existing CRLF files are still detected

-- Sync system clipboard with Neovim. Scheduled after startup because
-- loading the clipboard provider can slow down startup.
vim.schedule(function() o.clipboard = 'unnamedplus' end)

-- Searching
o.ignorecase = true -- Ignore case in search...
o.smartcase = true -- ...unless uppercase is used

-- UI
o.number = true -- Show line numbers
o.relativenumber = false -- Absolute line numbers only
o.signcolumn = 'yes' -- Always show sign column
o.cursorline = true -- Highlight current line
opt.termguicolors = true -- Enable 24-bit colors
o.showmode = false -- Don’t show mode (statusline handles that)
o.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50' -- Mode-specific cursors
opt.colorcolumn = '100' -- Vertical guide at column 100

-- Text and indentation
opt.tabstop = 4 -- 1 tab = 4 spaces (for display)
opt.shiftwidth = 4 -- Indent size for << and >>
opt.softtabstop = 4 -- Spaces per Tab press
opt.expandtab = true -- Convert tabs to spaces
opt.smartindent = true -- Smarter auto-indenting for code
o.breakindent = true -- Indent wrapped lines visually

-- Text formatting and wrapping
o.wrap = true
o.linebreak = true -- Wrap at word boundaries if wrap = true

-- Window and splits
o.splitright = true -- Vertical splits open to the right
o.splitbelow = true -- Horizontal splits open below

-- Other quality-of-life
o.list = false -- Show special characters (whitespace, tabs)
opt.listchars = { tab = '» ', trail = '.', nbsp = '␣' }
o.inccommand = 'split' -- Live preview of substitutions (:%s)

vim.diagnostic.config {
  virtual_text = {
    prefix = '',
    spacing = 4,
  },
  float = { border = 'single' },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}
