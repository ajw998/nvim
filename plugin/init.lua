-- Plugin Management
-- Will be using Packer.nvim for package management

-- Do not import plugins if Neovim is run as root,
-- or if Neovim version is < 0.5+
if require "utils".is_root() or not require "utils".is_neovim_05() then
    return
end

vim.cmd [[packadd packer.nvim]]

local packer_install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_packer_installed = vim.fn.empty(vim.fn.glob(packer_install_path)) == 0
-- local packer_compiled_path = packer_install_path .. "/plugin/packer_compiled.vim"
-- local is_packer_compiled = vim.fn.empty(vim.fn.glob(packer_compiled_path)) == 0

-- Automatically install Packer.nvim if not detected
if not is_packer_installed then
    vim.api.nvim_command("!git clone https://github.com/wbthomason/packer.nvim" .. packer_install_path)
    vim.api.nvim_command("packadd packer.nvim")
    print("Installed packer.nvim")
    is_packer_installed = 1
end

-- TODO Add packer nvim autoinstall
-- Reference: https://github.com/thanhvule0310/dotfiles/blob/main/nvim/lua/plugins/init.lua

require("packer").startup(
    function()
        local use = require "packer".use
        use "nvim-treesitter/nvim-treesitter"
        use { "nvim-treesitter/playground", disable = true }
        use "wbthomason/packer.nvim"
        use "tommcdo/vim-lion"
        use { "kovisoft/slimv", ft = { "lisp" }}
        -- Replaces vim-commentary
        use {"numToStr/Comment.nvim", config = function()
                require("Comment").setup()
            end}
        use "ggandor/lightspeed.nvim"
        use "tpope/vim-fugitive"
        use "tpope/vim-surround"
        use "tpope/vim-unimpaired"
        use "junegunn/fzf"
        use {"junegunn/fzf.vim", require = {"junegunn/fzf", run = "./install --bin"}}
        use {"hoob3rt/lualine.nvim", requires = {"kyazdani42/nvim-web-devicons", opt = true}}
        use {"neovim/nvim-lspconfig"}
        use {"fatih/vim-go", requires = { run = ":GoUpdateBinaries" }, ft = { "go" }, disable = true}
        use 'neovim/nvim-lspconfig'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-cmdline'
        use 'hrsh7th/nvim-cmp'
        use 'L3MON4D3/LuaSnip'
        use 'arcticicestudio/nord-vim'
    end
)

require("plugin.treesitter")
require("plugin.lualine")
require("plugin.slimv")
require("Comment").setup {}
require("lightspeed").setup{ ignore_case = true }
require("plugin.cmp")
