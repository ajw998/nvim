local colors = {
  black = "#282a3a",
  yellow = "#ffd76d",
  white = "#ffffff",
  red = "#ff657a",
  orange = "#ff9b5e",
  green = "#bad761",
  blue = "#9cd1bb",
  purple = "#c39ac9",
  pink = "#ff657a",
}

return {
  normal = {
    a = { fg = colors.black, bg = colors.yellow, gui = "bold" },
    b = { fg = colors.white, bg = '' },
    c = { fg = colors.white, bg = '' },
    x = { fg = colors.white, bg = '' },
    y = { fg = colors.white, bg = '' },
    z = { fg = colors.white, bg = '' },
  },
  insert = {
    a = { fg = colors.black, bg = colors.blue, gui = "bold" },
  },
  visual = {
    a = { fg = colors.black, bg = colors.orange, gui = "bold" },
  },
  replace = {
    a = { fg = colors.purple, bg = colors.orange, gui = "bold" },
  }
}
