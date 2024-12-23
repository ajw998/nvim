-- Neovim API and other variable declarations
local vim = vim
local homedir = os.getenv("HOME")
local b = vim.bo
local g = vim.g
local o = vim.o
local w = vim.wo
local map = vim.api.nvim_set_keymap

b.autoindent = true
b.expandtab = true
b.omnifunc = "syntaxcomplete#Complete"
b.shiftwidth = 2
b.softtabstop = 2
b.synmaxcol = 200
b.tabstop = 2
g.mapleader = ","
g.maplocalleader = ","
o.autoread = true
o.background = "dark"
o.backupdir = "/private/tmp"
o.cmdheight = 2
o.cursorline = true
o.directory = homedir .. "/.vim/swap"
o.hidden = true
o.ignorecase = true
o.laststatus = 3
o.mouse = "n"
o.number = true
o.showbreak = "↪"
o.showmatch = true
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.virtualedit = "block"

-- Keymaps
map("i", "jk", "<Esc>", {})
map("n", ";", ":", {})
map("n", "j", "gj", { noremap = true })
map("n", "<leader><space>", ':let@/=""<CR>', { noremap = true })

-- Filetypes
-- -- Create an autocommand group to avoid duplicates
vim.api.nvim_create_augroup("IndentationSettings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = "IndentationSettings",
    pattern = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "jsonc",
        "json",
        "html",
        "css",
    },
    callback = function()
        -- Set indentation options
        vim.bo.tabstop = 2 -- Number of spaces that a <Tab> counts for
        vim.bo.shiftwidth = 2 -- Size of an indent
        vim.bo.softtabstop = 2 -- Number of spaces that a <Tab> counts for while editing
        vim.bo.expandtab = true -- Use spaces instead of tabs
    end,
})
