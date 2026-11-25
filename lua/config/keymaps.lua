-- Core keymaps. Plugin keymaps are defined in each plugin's `keys` spec.
local map = vim.keymap.set

-- General
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics to location list' })
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Arrow keys print a reminder to use hjkl instead
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>', { desc = 'Reminder: use h' })
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>', { desc = 'Reminder: use l' })
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>', { desc = 'Reminder: use k' })
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>', { desc = 'Reminder: use j' })

-- Windows
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus upper window' })
-- Some terminals can't send distinct Ctrl+Shift keycodes
map('n', '<C-S-h>', '<C-w>H', { desc = 'Move window left' })
map('n', '<C-S-l>', '<C-w>L', { desc = 'Move window right' })
map('n', '<C-S-j>', '<C-w>J', { desc = 'Move window down' })
map('n', '<C-S-k>', '<C-w>K', { desc = 'Move window up' })
map('n', '<leader>s', '<cmd>split<CR>', { desc = 'Split window horizontally' })
map('n', '<leader>v', '<cmd>vsplit<CR>', { desc = 'Split window vertically' })

-- Scrolling keeps the cursor centered
map('n', '<C-d>', '<C-d>zz', { desc = 'Scroll half page down' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Scroll half page up' })

-- Editing
map('x', 'J', ":m '>+1<CR>gv=gv", { silent = true, desc = 'Move selection down' })
map('x', 'K', ":m '<-2<CR>gv=gv", { silent = true, desc = 'Move selection up' })
-- Uses Neovim's built-in `gc` comment operator
map('n', '<leader>kc', 'gcc', { remap = true, desc = 'Toggle comment (line)' })
map('x', '<leader>kc', 'gc', { remap = true, desc = 'Toggle comment (selection)' })
