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
          -- Same values like general color option can be used here.
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
   }
  },
}
