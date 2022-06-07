local theme = require'color.nord'.colors

return {
  normal = {
    a = { bg = theme.cyan, fg = theme.grey15, gui = 'bold'},
    c = { bg = 'NONE', fg = 'NONE', gui = 'bold'},
    b = { bg = 'NONE', fg = 'NONE'},
  },
  insert = {
    a = { bg = theme.cyan, fg = theme.grey15, gui = 'bold'},
  },
  visual = {
    a = { bg = theme.orange, fg = theme.grey15, gui = 'bold'},
  },
  replace = {
    a = { bg = theme.red, fg = theme.grey15, gui = 'bold'},
  },
  command = {
    a = { bg = theme.magenta, fg = theme.grey15, gui = 'bold'},
  },
  inactive = {
    a = { bg = theme.bg, fg = theme.bg, gui = 'bold'},
  }
}
