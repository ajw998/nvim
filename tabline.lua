local M  = {}

M.tab_title = function(bufnr)
  local filename = vim.fn.bufname(bufnr)

  if filename == '' then
    return '[No Name]'
  end

  return vim.fn.pathshorten(vim.fn.fnamemodify(filename, ':p:~:t'))
end

-- Modified function from https://github.com/alvarosevilla95/luatab.nvim/blob/master/lua/luatab/init.lua
-- Get the current buffer using the following
-- bufnr = vim.fn.bufnr("%")
M.get_dev_icons = function(bufnr)
  local icon
  local file = vim.fn.bufname(bufnr)
  local devicons = require'nvim-web-devicons'
  icon = devicons.get_icon(file, vim.fn.expand('#'..bufnr..':e'))

  return icon or ''
end

M.cell = function(index)
  local isSelected = vim.fn.tabpagenr() == index
  local buflist = vim.fn.tabpagebuflist(index)
  local winnr = vim.fn.tabpagewinnr(index)
  local bufnr = buflist[winnr]
  local hl = (isSelected and '%#TabLineSel#' or '%#TabLine#')
  return ' '..hl..M.tab_title(bufnr)
end

M.tabline = function()
    local line = ''
    for i = 1, vim.fn.tabpagenr('$'), 1 do
        line = line .. M.cell(i)
    end
    line = line .. '%#TabLineFill#%='
    if vim.fn.tabpagenr('$') > 1 then
        line = line .. '%#TabLine#%999XX'
    end
    return line
end

vim.opt.tabline = '%!v:lua.require\'tabline\'.tabline()'

return M
