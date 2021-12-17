require"lualine".setup{
  options= {
    section_separators = '',
    component_separators = '',
    icons_enabled = true,
    theme=require'color.lualine.monokai-pro'
  },
  extensions = {"fzf", "fugitive"},
  sections= {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      {
        'diff',
        colored = true, -- displays diff status in color if set to true
        diff_color = {
          added    = 'DiffAdd',    -- changes diff's added color
          modified = 'DiffChange', -- changes diff's modified color
          removed  = 'DiffDelete', -- changes diff's removed color you
        },
				-- Need to add space after each icon
        symbols = {added = ' ', modified = ' ', removed = ' '}, -- changes diff symbols
        source = nil, -- A function that works as a data source for diff.
                      -- it must return a table like
                      -- {added = add_count, modified = modified_count, removed = removed_count }
                      -- Or nil on failure. Count <= 0 won't be displayed.
      },
   },
	 lualine_x={
		  {
      'diagnostics',
      sources = {'nvim_diagnostic'},
      -- displays diagnostics from defined severity
      sections = {'error', 'warn', 'hint', 'info'},
      diagnostics_color = {
        error = 'DiagnosticError', -- changes diagnostic's error color
        warn  = 'DiagnosticWarn',  -- changes diagnostic's warn color
        info  = 'DiagnosticInfo',  -- changes diagnostic's info color
        hint  = 'DiagnosticHint',  -- changes diagnostic's hint color
      },
      symbols = { error = ' ', warn = ' ', info = ' ', hint = 'ﯦ ' },
      colored = true, -- displays diagnostics status in color if set to true
			update_in_insert = false,
      always_visible = false, -- Show diagnostics even if count is 0, boolean or function returning boolean
			padding = 2
    }
		},
	 lualine_y={
			{ 'filetype', color = { bg = "none", fg="none" } }
		},
	 lualine_z={'location'},
  },
}
