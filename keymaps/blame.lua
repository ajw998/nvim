-- Require git-pr utility
--
function _G.fetch_pr()
  local wordUnderCursor = vim.fn.expand("<cword>")
  vim.fn.system("git-pr "..wordUnderCursor)
end
