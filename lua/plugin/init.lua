local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  "nvim-treesitter/nvim-treesitter",
  "phaazon/hop.nvim",
  "tommcdo/vim-lion",
  { "kovisoft/slimv", ft = { "lisp" } },
  { "numToStr/Comment.nvim" },
  "tpope/vim-surround",
  "kshenoy/vim-signature",
  "tpope/vim-unimpaired",
  {
  "ibhagwan/fzf-lua",
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({})
  end
  },
  { "hoob3rt/lualine.nvim", dependencies = { "kyazdani42/nvim-web-devicons", opt = true } },
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  "sainnhe/sonokai",
  "saadparwaiz1/cmp_luasnip",
  "onsails/lspkind.nvim",
  { 'NeogitOrg/neogit', lazy=true, dependencies = 'nvim-lua/plenary.nvim' }
}, {
  ui = {
    icons = {
      cmd = "⌘",
      event = "📅",
      ft = "📂",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
require("Comment").setup {
  toggler = {
    ---Line-comment toggle keymap
    line = "gcc",
    ---Block-comment toggle keymap
    block = "gbc",
  },
}
require("plugin.cmp")
require("nvim-treesitter.configs").setup{ 
  highlight = { 
    enable = true,
     -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "typescript" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,
       -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      -- list of language that will be disabled
      disable = { "c", "rust" },
      -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
              return true
          end
      end,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
  },
}
require('hop').setup()
local hop = require('hop')
local directions = require('hop.hint').HintDirection

vim.keymap.set('n', 's', function()
  hop.hint_char2({ direction = directions.AFTER_CURSOR })
end, {remap=true})

vim.keymap.set('n', 'S', function()
  hop.hint_char2({ direction = directions.BEFORE_CURSOR})
end, {remap=true})

require('fzf-lua').setup({ 'max-perf' })
require('neogit').setup{}
