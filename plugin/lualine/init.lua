function get_syn_highlight(group, key)
  local ui = {}
  ui["gui"..key] = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), key.."#", "gui")
  return ui
end

require"lualine".setup{
  options= {
    section_separators = { left = '', right = ''},
    component_separators = { left = '', right = '' },
    icons_enabled = true,
    -- theme='nord'
    theme=require'plugin.lualine.nord-custom'
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
          added    = get_syn_highlight("DiffAdd", "fg"),
          modified = get_syn_highlight("DiffChange", "fg"),
          removed = get_syn_highlight("DiffDelete", "fg") 
        },
        -- Need to add space after each icon
        symbols = { added = ' ', modified = '  ', removed = '  '},
        source = nil,
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
          error = get_syn_highlight("DiagnosticError", "fg"),
          warn = get_syn_highlight("DiagnosticWarn", "fg"),
          info = get_syn_highlight("DiagnosticInfo", "fg"),
          hint = get_syn_highlight("DiagnosticHint", "fg"),
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
