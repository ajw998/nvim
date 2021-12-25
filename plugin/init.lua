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

require("packer").startup(
    function()
        local use = require "packer".use
        -- Packer can manage itself
        use "nvim-treesitter/nvim-treesitter-refactor"
        use "nvim-treesitter/nvim-treesitter-textobjects"
        use "nvim-treesitter/nvim-treesitter"
        use "nvim-treesitter/playground"
        use "wbthomason/packer.nvim"
        use "/usr/local/opt/fzf"
        use "tommcdo/vim-lion"
        -- Replaces vim-commentary
        use {"numToStr/Comment.nvim", config = function()
                require("Comment").setup()
            end}
        -- Replaces vim-sneak
        use "ggandor/lightspeed.nvim"
        use "tpope/vim-fugitive"
        use "tpope/vim-surround"
        use "tpope/vim-unimpaired"
        use {"junegunn/fzf.vim", require = {"junegunn/fzf", run = "./install --bin"}}
        use {"hoob3rt/lualine.nvim", requires = {"kyazdani42/nvim-web-devicons", opt = true}}
        use {"neovim/nvim-lspconfig"}
        -- use {'neovimhaskell/haskell-vim', ft = { 'hs' }}
        use {"ms-jpq/coq_nvim", branch = "coq"}
        use {"ms-jpq/coq.artifacts", branch = "artifacts"}
        use {"fatih/vim-go", requires = { run = ":GoUpdateBinaries" }, ft = { "go" }}
    end
)

require("plugin.treesitter")
require("plugin.vim-sneak")
require("plugin.lualine")
require("Comment").setup {}
