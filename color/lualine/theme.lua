local theme = require'color.nord'.colors

return {
  normal = {
    a = {bg = theme.grey15, fg = theme.cyan, gui = 'bold'},
    c = { bg = 'NONE', fg = 'NONE', gui = 'bold'},
    b = { bg = 'NONE', fg = 'NONE'},
  },
  insert = {
    a = {bg = theme.cyan, fg = theme.black, gui = 'bold'},
  },
  visual = {
    a = {bg = theme.orange, fg = theme.black, gui = 'bold'},
  },
  replace = {
    a = {bg = theme.red, fg = theme.black, gui = 'bold'},
  },
  command = {
    a = {bg = theme.magenta, fg = theme.black, gui = 'bold'},
  },
  inactive = {
    a = {bg = theme.bg, fg = theme.bg, gui = 'bold'},
  }
}
