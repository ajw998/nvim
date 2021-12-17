require"lualine".setup{
  options= {
    section_separators = '',
    component_separators = '',
    icons_enabled = false,
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
        symbols = {added = '增', modified = '改', removed = '刪'}, -- changes diff symbols
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
      symbols = { error = '錯', warn = '戒', info = '吿', hint = '點' },
      colored = true, -- displays diagnostics status in color if set to true
			update_in_insert = false,
      always_visible = false, -- Show diagnostics even if count is 0, boolean or function returning boolean
    }
		},
	 lualine_y={},
	 lualine_z={'location'},
  },
}
