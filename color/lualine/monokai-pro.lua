local theme = require'color.monokai'.colors

return {
  normal = {
    a = {bg = theme.lightgreen, fg = theme.black, gui = 'bold'},
    c = { bg = '', fg = '', gui = 'bold'},
  },
  insert = {
    a = {bg = theme.teal, fg = theme.black, gui = 'bold'},
  },
  visual = {
    a = {bg = theme.orange, fg = theme.black, gui = 'bold'},
  },
  replace = {
    a = {bg = theme.red, fg = theme.black, gui = 'bold'},
  },
  command = {
    a = {bg = theme.purple, fg = theme.black, gui = 'bold'},
  },
  inactive = {
    a = {bg = theme.black, fg = theme.black, gui = 'bold'},
  }
}
