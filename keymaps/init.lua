-- Keymaps

local map = vim.api.nvim_set_keymap

-- Remove <Space> as leader key in normal mode, then
-- set comma <,> as leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ','

-- Open init.lua
map('n', '<leader>,', ':e ~/.config/nvim/init.lua <CR>', {})
-- Open register
map('n', '<leader>R', ':reg <CR>', { noremap = true })
-- Copy current file path
map('n', '<leader>cp', ':let @*=expand("%:p") <CR>', {})
-- Self-explanatory
map('i', 'jk', '<Esc>', {})
-- Map semi-colon to colon
map('n', ';', ':', {})
-- Move down visual (screen) lines instead of physical lines
map('n', 'j', 'gj', { noremap = true })
-- Remove search match highlights
map('n', '<leader><space>', ':let@/=""<CR>', { noremap = true })
-- Close buffer
map('n', '<leader>x', ':bd <CR>', { noremap = true })
-- Vim-sneak
map('n', 'f', '<Plug>Sneak_s', {})
map('n', 'F', '<Plug>Sneak_S', {})
-- ctags
map('n', '\\r', ':!ctags -R . <CR>', { noremap = true})
-- Yank to clipbaord
map('v', '<leader>y', '"*y', { noremap = true })

-- Telescope
-- Searh for files from current working directory
map('n', '<leader>t', ':Files <CR>', { noremap = true })
-- Open buffer list
map('n', '<leader>b', '<cmd>lua require("telescope.builtin").buffers()<CR>', { noremap = true })
-- Live grep
map('n', '<leader>g', '<cmd>lua require("telescope.builtin").live_grep()<CR>', { noremap = true })
map('n', '<leader>hh', '<cmd>lua require("telescope.builtin").help_tags()<CR>', { noremap = true })
