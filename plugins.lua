-- Plugin Management
-- Will be using Packer.nvim for package management

-- Do not import plugins if Neovim is run as root,
-- or if Neovim version is < 0.5+
if require'utils'.is_root() or not require'utils'.is_neovim_05() then
    return
end

vim.cmd [[packadd packer.nvim]]

local packer_install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_compiled_path = packer_install_path .. "/plugin/packer_compiled.vim"
local is_packer_installed = vim.fn.empty(vim.fn.glob(packer_install_path)) == 0
local is_packer_compiled = vim.fn.empty(vim.fn.glob(packer_compiled_path)) == 0

-- Automatically install Packer.nvim if not detected
if not is_packer_installed then
    vim.api.nvim_command("!git clone https://github.com/wbthomason/packer.nvim" .. packer_install_path)
    vim.api.nvim_command("packadd packer.nvim")
    print("Installed packer.nvim")
    is_packer_installed = 1
end


return require('packer').startup(function()
    local use = require'packer'.use
    use 'hrsh7th/nvim-compe'
    use 'nvim-treesitter/nvim-treesitter'
    use 'neovim/nvim-lspconfig'
    use '/usr/local/opt/fzf'
    use 'editorconfig/editorconfig-vim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/playground'
    use 'tommcdo/vim-lion'
    use 'tpope/vim-surround'
    use { 'junegunn/fzf.vim', require = { 'junegunn/fzf', run = './install --bin' } }
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use 'justinmk/vim-sneak'
    use 'tpope/vim-commentary'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'
end)
