local M = {}

M.get_tab_title = function(bufnr)
  local filename = vim.fn.bufname(bufnr)

  if filename == '' then
    return '[No Name]'
  end

  return vim.fn.pathshorten(vim.fn.fnamemodify(filename, ':p:~:t'))
end

return M
