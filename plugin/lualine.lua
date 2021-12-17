require"lualine".setup{
  options= {
    section_separators = '',
    component_separators = '|',
    icons_enabled = false,
    theme=require'color.lualine.monokai-pro'
  },
  extensions = {"fzf", "fugitive"}
}
