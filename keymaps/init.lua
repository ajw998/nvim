require "keymaps.blame"

-- Keymaps
local map = vim.api.nvim_set_keymap

-- Copy current file name to system clipboard
function _G.copy_file_name()
  local filename = vim.fn.expand("%")
  local repo_name = vim.fn.system("basename `git rev-parse --show-toplevel`"):gsub("^%s*(.-)%s*$", "%1")
  if vim.v.shell_error == 1 then
      -- If not in git repository, simply copy the filename
      vim.fn.setreg("*", vim.fn.expand("%p"))
    else
      local full_name = table.concat({ repo_name, "/", filename })
      vim.fn.setreg("*", full_name)
    end
end

-- Remove <Space> as leader key in normal mode, then
-- set comma <,> as leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ','

-- Open init.lua
map('n', '<leader>,', ':e ~/.config/nvim/init.lua <CR>', {})
-- Open register
map('n', '<leader>R', ':reg <CR>', { noremap = true })
-- Copy current file path
-- map('n', '<leader>cp', ':let @*=expand("%:p") <CR>', {})
map('n', '<leader>cp', ':lua copy_file_name() <CR>', { silent = true })
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
-- Searh for files from current working directory
map('n', '<leader>t', ':Files <CR>', { noremap = true })
-- Open buffer list
map('n', '<leader>b', ':Buffers<CR>', { noremap = true })
