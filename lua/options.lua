-- Short aliases for convenience
local o = vim.o
local opt = vim.opt

-- General behavior
o.encoding = 'utf-8' -- Use UTF-8 encoding
o.confirm = true -- Ask to save before quitting unsaved changes
o.clipboard = 'unnamedplus' -- Sync system clipboard with Neovim
o.mouse = 'a' -- Enable mouse support
o.undofile = true -- Save undo history between sessions
o.scrolloff = 10 -- Keep 10 lines visible above/below cursor
o.updatetime = 250 -- Faster updates for plugins
o.timeoutlen = 300 -- Shorter timeout for mapped sequences
o.fileformat = 'unix' -- File format -> lf
o.ff = 'unix'
-- Searching
o.ignorecase = true -- Ignore case in search...
o.smartcase = true -- ...unless uppercase is used
o.hlsearch = true -- Highlight all search matches
o.incsearch = true -- Show matches as you type

-- UI
o.number = true -- Show line numbers
o.relativenumber = true -- Relative numbers for easy navigation
o.signcolumn = 'yes' -- Always show sign column
o.cursorline = false -- Highlight current line
opt.termguicolors = true -- Enable Terminal Colors
o.showmode = false -- Don’t show mode (plugin handles that)
o.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50' -- Mode-specific cursors
vim.g.have_nerd_font = true -- Enable nerd font

-- Text and indentation
opt.tabstop = 4 -- 1 tab = 4 spaces (for display)
opt.shiftwidth = 4 -- Indent size for << and >>
opt.softtabstop = 4 -- Spaces per Tab press
opt.expandtab = true -- Convert tabs to spaces
opt.smartindent = true -- Smarter auto-indenting for code
opt.autoindent = true -- Copy indent from current line
o.smarttab = true -- Use shiftwidth when pressing Tab at line start
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
o.lazyredraw = true -- Improve performance on macros and large output
