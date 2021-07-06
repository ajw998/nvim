-- Theme: Modified Monokai Pro (Octagon)
-- Author: Andrew Wong
-- Description: Customised implementation of Monokai Pro (Octagon)

-- require "nvim-treesitter.highlight"

local vim = vim

local monokai_pro_octagon = {
    blue       = "#204a87",
    grey       = "#939293",
    lightgreen = "#bad761",
    lightgrey  = "#b2b9bd",
    orange     = "#fc9867",
    purple     = "#c39ac9",
    red        = "#ff657a",
    teal       = "#9cd1bb",
    white      = "#eaf1f1",
    yellow     = "#ffd76d"
}

function monokai_pro_octagon.highlight(group, colour)
    local style = colour.style and 'gui=' .. colour.style or 'gui=NONE'
    local fg = colour.fg and 'guifg=' .. colour.fg or 'guifg=NONE'
    local bg = colour.bg and 'guibg=' .. colour.bg or 'guibg=NONE'
    local sp = colour.sp and 'guisp=' .. colour.sp or ''
    vim.api.nvim_command('highlight ' .. group .. ' ' .. style .. ' ' .. fg ..
        ' ' .. bg..' '..sp)
end

function monokai_pro_octagon.base_syntax()
    local base_syntax = {
    PMenu        = { fg = monokai_pro_octagon.lightgrey, bg="NONE" };
  PMenuSel     = { fg = "#282a3a", bg=monokai_pro_octagon.yellow };
  Comment      = { fg = "#727072" };
  ColorColumn  = { fg = "NONE", bg = "NONE" };
  Cursor       = { fg = monokai_pro_octagon.white };
  CursorLineNR = { fg = monokai_pro_octagon.yellow };
  Identifier   = { fg = monokai_pro_octagon.red };
  Keyword      = { fg = monokai_pro_octagon.red };
  LineNr       = { fg = "#696d77" };
  MatchParen   = { fg = monokai_pro_octagon.red, style="underline" };
  NonText      = { fg = "#696769" };
  Number       = { fg = monokai_pro_octagon.purple };
  Operator     = { fg = monokai_pro_octagon.red };
  Statement    = { fg = monokai_pro_octagon.red };
  StatusLine   = { fg = monokai_pro_octagon.white, bg="#696769" };
  String       = { fg = monokai_pro_octagon.yellow };
  VertSplit    = { fg = "#696769", bg = "NONE" };
  Visual       = { bg = "#323343" };
}
    return base_syntax
end


function monokai_pro_octagon.load_plugin_syntax()
    local plugin_syntax = {
      TSPunctBracket = { fg = monokai_pro_octagon.white };
      TSBoolean      = { fg = monokai_pro_octagon.purple };
      TSComment      = { fg = monokai_pro_octagon.lightgrey };
      TSString       = { fg = monokai_pro_octagon.yellow };
      TSError        = { fg = monokai_pro_octagon.red };
      TSConstructor  = { fg = monokai_pro_octagon.lightgreen };
      TSAnnotation   = { fg = monokai_pro_octagon.lightgrey };
      TSNumber       = { fg = monokai_pro_octagon.purple };
      TSCharacter    = { fg = monokai_pro_octagon.purple };
      TSParameter    = { fg = monokai_pro_octagon.white };
      TSConstBuiltin = { fg = monokai_pro_octagon.teal };
      TSFunction     = { fg = monokai_pro_octagon.lightgreen };
      TSProperty     = { fg = monokai_pro_octagon.white };
      TSLiteral      = { fg = monokai_pro_octagon.white };
      TSType         = { fg = monokai_pro_octagon.teal };
      TSTitle        = { fg = monokai_pro_octagon.white };
      LspDiagnosticsDefaultWarning = { fg = monokai_pro_octagon.orange };
      LspDiagnosticsVirtualTextWarning = { fg = monokai_pro_octagon.orange };
      LspDiagnosticsVirtualTextError = { fg = monokai_pro_octagon.red };
      LspReferenceText = { fg = "#282a3a",  bg = monokai_pro_octagon.yellow };
      LspReferenceRead = { fg = "#282a3a", bg = monokai_pro_octagon.yellow };
      LspReferenceWrite = { bg = monokai_pro_octagon.yellow };
    }
    return plugin_syntax
end

async_load_plugin = vim.loop.new_async(vim.schedule_wrap(function ()
  local syntax = monokai_pro_octagon.load_plugin_syntax()
  for group,colors in pairs(syntax) do
    monokai_pro_octagon.highlight(group,colors)
  end
  async_load_plugin:close()
end))

function monokai_pro_octagon.get_monokai_color()
  return monokai_pro_octagon
end

function monokai_pro_octagon.colourscheme()
  vim.api.nvim_command('hi clear')
  if vim.fn.exists('syntax_on') then
    vim.api.nvim_command('syntax reset')
  end
  vim.o.background = 'dark'
  vim.o.termguicolors = true
  local syntax = monokai_pro_octagon.base_syntax()
  for group,colors in pairs(syntax) do
    monokai_pro_octagon.highlight(group,colors)
  end
  async_load_plugin:send()
end

monokai_pro_octagon.colourscheme()

return monokai_pro_octagon
