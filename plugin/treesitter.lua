require'nvim-treesitter.configs'.setup {
    ensure_installed = {
				"bash",
				"css",
				"go",
				"html",
				"javascript",
				"json",
				"jsonc",
				"lua",
				"query",
				"swift",
				"tsx",
				"typescript",
				"yaml",
    },
	indent = {
		enable = true
	};
    playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  refactor = {
		highlight_current_scope = {
			enable = false
		},
		navigation = {
      enable = true,
      keymaps = {
        list_definitions = "gD",
        list_definitions_toc = "gnT",
      },
    },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
  },
  highlight = {
    enable = true,
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"},
  },
}
