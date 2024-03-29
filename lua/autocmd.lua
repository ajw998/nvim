local api = vim.api

-- Create augroup
-- @returns void
-- Source: https://github.com/ibhagwan/nvim-lua/blob/main/lua/autocmd.lua
local function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    api.nvim_command('augroup '..group_name)
    api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      api.nvim_command(command)
    end
    api.nvim_command('augroup END')
  end
end

local autocmd = {
  yank_highlight = {
    {'TextYankPost', '*', 'silent! lua vim.highlight.on_yank{ higroup="IncSearch", timeout=500 }'}
  };
  go = {
    {'BufEnter,BufNewFile', '*.go', 'setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab'}
  };
  json = {
    {'BufEnter,BufNewFile,BufRead', '*.json', 'setlocal tabstop=2 softtabstop=4 shiftwidth=2 expandtab autoindent' }
  };
  zsh = {
    {'BufEnter,BufNewFile', '*.lua', 'setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2'}
  };
  lua = {
    {'BufEnter,BufNewFile', '*.lua', 'setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2'}
  };
  python = {
    {'BufNewFile, BufRead', '*.py', 'setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent'}
  };
  plaintext = {
    {'FileType', 'text', 'setlocal listchars= syntax=off spell tw=79'}
  };
  javascript = {
    {'BufNewFile', '*.js', 'setlocal tabstop=2 softtabstop=2 shiftwidth=2 textwidth=79 expandtab autoindent' },
  }
}

nvim_create_augroups(autocmd)
