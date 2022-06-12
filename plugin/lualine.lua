require"lualine".setup{
  options= {
    section_separators = { left = '', right = ''},
    component_separators = { left = '', right = '' },
    icons_enabled = true,
    theme='nord'
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
          added    = {  guifg="#A3BE8C" },
          modified = {  guifg="#EBC8B8" },
          removed =  {  guifg="#8F616A" },
        },
        -- Need to add space after each icon
        symbols = {added = ' ', modified = '  ', removed = '  '}, -- changes diff symbols
        source = nil, -- A function that works as a data source for diff.
                      -- it must return a table like
                      -- {added = add_count, modified = modified_count, removed = removed_count }
                      -- Or nil on failure. Count <= 0 won't be displayed.
      },
   },
   lualine_c = {
      {
        'filename',
        file_status = true,
        filetype_names = {
          packer = 'Packer',
          fzf = 'FZF',
        }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )
        path = 1,
				shorting_target = 35,
        symbols = {
          modified = ' ●',      -- Text to show when the file is modified.
          readonly = ' ',      -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
      }
      },
   },
   lualine_x={
      { 'filetype', color = { bg = "none", fg="none" } }
    },
   lualine_y={'location'},
   lualine_z= {
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
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
        -- colored = true, -- displays diagnostics status in color if set to true
        update_in_insert = false,
        always_visible = false, -- Show diagnostics even if count is 0, boolean or function returning boolean
        padding = 2,
      }
    },
  },
}
