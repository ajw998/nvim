require "nvim-treesitter.configs".setup {
    textobjects = {
        select = {
            enable = false,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = false,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        }
    },
    indent = {
        enable = false
    },
    playground = {
        enable = false,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?"
        }
    },
    refactor = {
        highlight_current_scope = {
            enable = false
        },
        navigation = {
            enable = false,
            keymaps = {
                list_definitions = "gD",
                list_definitions_toc = "gnT"
            }
        },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "grr"
            }
        }
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(lang, bufnr)
          return lang == "c" or vim.api.nvim_buf_line_count(bufnr) > 3000
        end
    },
    query_linter = {
        enable = false,
        use_virtual_text = true,
        lint_events = {"BufWrite", "CursorHold"}
    }
}

