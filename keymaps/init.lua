require "keymaps.blame"

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
-- Current file path
map('n', '<leader>cpa', ':lua copy_file_name(3) <CR>', { silent = true })
map('n', '<leader>cpg', ':lua copy_file_name() <CR>', { silent = true })
map('n', '<leader>pr', ':lua fetch_pr() <CR>', { silent = true })
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
map('n', 'f', '<Plug>Lightspeed_s', {})
map('n', 'F', '<Plug>Lightspeed_S', {})
-- ctags
map('n', '\\r', ':!ctags -R . <CR>', { noremap = true})
-- Yank to clipbaord
map('v', '<leader>y', '"*y', { noremap = true })
-- Directory and File browser
map('n', '<leader>t', ':Files <CR>', { noremap = true })
-- Buffer
map('n', '<leader>b', ':Buffers<CR>', { noremap = true })
map('n', '<leader>sy', ':echo synIDattr(synID(line("."),col("."),0),"name") <CR>', { noremap = true })
