local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local utils = require("utils")
local g = vim.g

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    defaults = { lazy = true },
    ui = { border = "rounded" },
    performance = {
        cache = {
            enabled = true,
        },
        rtp = {
            disabled_plugins = {
                "netrwPlugin",
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    spec = {
        -- import your plugin
        {
            "m4xshen/autoclose.nvim",
            init = function()
                require("autoclose").setup()
            end,
        },
        "numToStr/Comment.nvim",
        {
            "ggandor/leap.nvim",
            init = function()
                require("leap").create_default_mappings()
            end,
        },
        {
            "sainnhe/sonokai",
            lazy = false,
            priority = 1000,
            config = function()
                -- Optionally configure and load the colorscheme
                g.sonokai_enable_italic = true
                g.sonokai_style = "andromeda"
                g.sonokai_better_performance = 1
                g.sonokai_transparent_background = 1
                vim.cmd.colorscheme("sonokai")
            end,
        },
        {
            "ibhagwan/fzf-lua",
            cmd = "FzfLua",
            keys = {
                { "<leader>t", ":FzfLua files<cr>", desc = "Find files" },
                { "<leader>rg", ":FzfLua live_grep<cr>", desc = "Ripgrep" },
                {
                    "<leader>st",
                    ":lua require('fzf-lua').grep({search='TODO|HACK|PERF|NOTE|FIX', no_esc=true})<CR>",
                    desc = "Search tags TODO|FIX...",
                },
            },
        },
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
            },
            enabled = function()
                local in_prompt = vim.api.nvim_buf_get_option(0, "buftype") == "prompt"
                if in_prompt then
                    return false
                end
                local context = require("cmp.config.context")
                return not (
                    context.in_treesitter_capture("comment") == true
                    or context.in_syntax_group("Comment")
                )
            end,
            opts = function()
                local cmp = require("cmp")
                return {
                    experimental = {
                        native_menu = false,
                        ghost_text = true,
                    },
                    formatting = {
                        format = function(_, item)
                            item.kind =
                                string.format("%s %s", utils.icons.lsp[item.kind], item.kind)
                            return item
                        end,
                    },
                    confirmation = {
                        get_commit_characters = function()
                            return {}
                        end,
                    },
                    view = {
                        entries = "custom",
                    },
                    completion = {
                        completeopt = "menu,menuone,noinsert",
                        keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
                        keyword_length = 1,
                    },
                    snippet = {
                        expand = function(args)
                            require("luasnip").lsp_expand(args.body)
                        end,
                    },
                    mapping = {
                        ["<C-n>"] = cmp.mapping.select_next_item({
                            behavior = cmp.SelectBehavior.Insert,
                        }),
                        ["<C-p>"] = cmp.mapping.select_prev_item({
                            behavior = cmp.SelectBehavior.Insert,
                        }),
                        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                        ["<C-f>"] = cmp.mapping.scroll_docs(4),
                        ["<C-e>"] = cmp.mapping.abort(),
                        ["<C-y>"] = cmp.mapping(
                            cmp.mapping.confirm({
                                behavior = cmp.ConfirmBehavior.Insert,
                                select = true,
                            }),
                            { "i", "c" }
                        ),

                        ["<c-space>"] = cmp.mapping({
                            i = cmp.mapping.complete(),
                            c = function(
                                _ --[[fallback]]
                            )
                                if cmp.visible() then
                                    if not cmp.confirm({ select = true }) then
                                        return
                                    end
                                else
                                    cmp.complete()
                                end
                            end,
                        }),
                        ["<tab>"] = cmp.config.disable,
                        ["<C-k>"] = cmp.mapping.complete({ reason = cmp.ContextReason.Auto }),
                    },
                    sources = cmp.config.sources({
                        { name = "cody" },
                        { name = "nvim_lsp", keyword_length = 2 },
                        { name = "nvim_lua" },
                        -- { name = "luasnip" },
                        { name = "path" },
                        { name = "buffer", keyword_length = 2 },
                    }),
                    preselect = cmp.PreselectMode.None,
                    sorting = {
                        comparator = {
                            cmp.config.compare.offset,
                            cmp.config.compare.exact,
                            cmp.config.compare.score,
                            cmp.config.compare.recently_used,
                            cmp.config.compare.kind,
                        },
                    },
                }
            end,
        },
        {
            "neovim/nvim-lspconfig",
            event = "BufReadPost",
            dependencies = {
                { "williamboman/mason.nvim", opts = {}, run = ":MasonUpdate" }, -- installing LSPs automaticlly
                "williamboman/mason-lspconfig.nvim", -- lsp configuration for mason lsp
                "hrsh7th/nvim-cmp",
                {
                    "lewis6991/gitsigns.nvim",
                    init = function()
                        require("gitsigns").setup()
                    end,
                },
                {
                    "glepnir/lspsaga.nvim",
                    opts = {
                        code_action = {
                            show_server_name = true,
                            extend_gitsigns = false,
                        },
                        lightbulb = {
                            enable = false,
                        },
                        diagnostic = {
                            on_insert = false,
                            on_insert_follow = false,
                        },
                        rename = {
                            in_select = false,
                        },
                    },
                },
            },
            opts = {
                servers = { "tsserver", "lua_ls", "vimls", "jsonls", "html", "cssls", "clangd" },
            },
            config = function(_, opts)
                local on_attach = function(_, bufnr)
                    vim.diagnostic.config({
                        virtual_text = false,
                    })
                    -- Enable completion triggered by <c-x><c-o>
                    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

                    -- Mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local bufopts = { noremap = true, silent = true, buffer = bufnr }
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
                    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
                    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
                    vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", bufopts)
                    vim.keymap.set("n", "]c", "<cmd>Lspsaga diagnostic_jump_next<CR>", bufopts)
                    vim.keymap.set("n", "[c", "<cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts)
                end

                for name, icon in pairs(utils.icons.diagnostics) do
                    name = "DiagnosticSign" .. name
                    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
                end
                vim.diagnostic.config(opts.diagnostics)
                require("lspconfig").clangd.setup({ on_attach = on_attach })
                require("lspconfig").tsserver.setup({ on_attach = on_attach })
            end,
        },
        {
            "nvim-treesitter/nvim-treesitter",
            dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
            build = ":TSUpdate",
            event = "BufReadPost",
            config = function(_, opts)
                require("nvim-treesitter.configs").setup(opts)
            end,
            opts = {
                ensure_installed = {
                    "javascript",
                    "typescript",
                    "tsx",
                    "lua",
                    "json",
                    "jsonc",
                    "html",
                    "css",
                    "bash",
                    "markdown",
                    "vim",
                    "gitignore",
                    "gitcommit",
                    "diff",
                    "yaml",
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                    -- swap = {
                    --     enable = true,
                    --     swap_next = {
                    --         ["<leader>a"] = "@parameter.inner",
                    --     },
                    --     swap_previous = {
                    --         ["<leader>A"] = "@parameter.inner",
                    --     },
                    -- },
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<leader>ss", -- set to `false` to disable one of the mappings
                        node_incremental = "<leader>si",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                },
            },
        },
    },
    checker = { enabled = false },
})
