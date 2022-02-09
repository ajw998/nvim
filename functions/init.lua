local M = {}

-- Require git-pr utility
function _G.fetch_pr()
  local wordUnderCursor = vim.fn.expand("<cword>")
  vim.fn.system("git-pr "..wordUnderCursor)
end

-- Copy current file name to system clipboard
-- Allow to copy either path relative to git project or full path
function _G.copy_file_name(path)
  local filename = vim.fn.expand("%")
  if vim.v.shell_error == 1 or path == 3 then
      -- If not in git repository, simply copy the filename
      vim.fn.setreg("*", vim.fn.expand("%:p:h"))
    else
      local repo_name = vim.fn.system("basename `git rev-parse --show-toplevel`"):gsub("^%s*(.-)%s*$", "%1")
      local full_name = table.concat({ repo_name, "/", filename })
      vim.fn.setreg("*", full_name)
    end
end

return M
