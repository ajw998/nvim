local M = {}

local MAX_LINE_NUMBER = 5000

-- Disable neovim treesitter if file exceeds number of line
function _G.disable_language_plugins()
  if vim.fn.line("$") > MAX_LINE_NUMBER then
    vim.cmd('TSDisableAll highlight')
    vim.cmd('TSDisableAll indent')
    vim.cmd('TSDisableAll playground')
    vim.cmd('TSDisableAll query_linter')
    vim.cmd('TSDisableAll refactor')
    vim.cmd('TSDisableAll textobjects')
  end
end

-- Require git-pr utility
function _G.fetch_pr()
  local wordUnderCursor = vim.fn.expand("<cword>")
  vim.fn.system("git-pr "..wordUnderCursor)
end

return M
