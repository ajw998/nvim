local M = {}

-- Checks if current Neovim version is 0.5+
-- @return boolean: Boolean representing whether Neovim version is 0.5+
function M.is_neovim_05()
    if vim.fn.has('nvim-0.5') == 1 then
        return true
    end
    return false
end

-- Check if Neovim is being run as root
-- @return boolean: Boolean representing whether Neovim is being run as root
function M.is_root()
    local id = vim.fn.systemlist "id -u"
    return ((id[1] or "") == "0")
end

function M.get_system_name()
end

return M
