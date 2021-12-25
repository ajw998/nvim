-- require "nvim-treesitter.highlight"
local theme = require'color.monokai'.colors

local vim = vim

function theme.highlight(group, colour)
    local style = colour.style and 'gui=' .. colour.style or 'gui=NONE'
    local fg = colour.fg and 'guifg=' .. colour.fg or 'guifg=NONE'
    local bg = colour.bg and 'guibg=' .. colour.bg or 'guibg=NONE'
    local sp = colour.sp and 'guisp=' .. colour.sp or ''
    vim.api.nvim_command('highlight ' .. group .. ' ' .. style .. ' ' .. fg ..
        ' ' .. bg..' '..sp)
end

function theme.base_syntax()
    local base_syntax = {
    Search       = { fg = "#2d2a2e", bg=theme.yellow };
    IncSearch    = { fg = "#2d2a2e", bg=theme.yellow };
    ErrorMsg     = { fg = "NONE", bg="NONE" };
    PMenu        = { fg = theme.lightgrey, bg="NONE" };
    PMenuSel     = { fg = "#282a3a", bg=theme.yellow };
    Comment      = { fg = "#727072" };
    SignColumn   = { fg = "NONE", bg = "NONE" };
    ColorColumn  = { fg = "NONE", bg = "NONE" };
    Cursor       = { fg = theme.white };
    CursorLineNR = { fg = theme.yellow };
    Identifier   = { fg = theme.red };
    Keyword      = { fg = theme.red };
    Title        = { fg = theme.white };
    LineNr       = { fg = "#696d77" };
    MatchParen   = { fg = theme.red, style="underline" };
    NonText      = { fg = "#696769" };
    Number       = { fg = theme.purple };
    Operator     = { fg = theme.red };
    Statement    = { fg = theme.red };
    StatusLine   = { fg = theme.white, bg="#696769" };
    String       = { fg = theme.yellow };
    VertSplit    = { fg = "#696769", bg = "NONE" };
    Visual       = { bg = "#323343" };
}
    return base_syntax
end

function theme.load_plugin_syntax()
    local plugin_syntax = {
      TSSymbol                         = { fg = theme.red };
      TSPunctBracket                   = { fg = theme.white };
      TSBoolean                        = { fg = theme.purple };
      TSComment                        = { fg = theme.lightgrey };
      TSString                         = { fg = theme.yellow };
      TSError                          = { fg = theme.red };
      TSConstructor                    = { fg = theme.lightgreen };
      TSAnnotation                     = { fg = theme.lightgrey };
      TSNumber                         = { fg = theme.purple };
      TSCharacter                      = { fg = theme.purple };
      TSParameter                      = { fg = theme.white };
      TSConstBuiltin                   = { fg = theme.teal };
      TSFunction                       = { fg = theme.lightgreen };
      TSProperty                       = { fg = theme.white };
      TSLiteral                        = { fg = theme.white };
      TSType                           = { fg = theme.teal };
      TSTypeBuiltin                    = { fg = theme.teal };
      TSTitle                          = { fg = theme.white };
      DiagnosticError                  = { fg = theme.red };
      DiagnosticWarn                   = { fg = theme.orange };
      DiagnosticHint                   = { fg = theme.teal };
      LspDiagnosticsVirtualTextWarning = { fg = theme.orange };
      LspDiagnosticsVirtualTextError   = { fg = theme.red };
      LspReferenceText                 = { fg = "#282a3a",  bg = theme.yellow };
      LspReferenceRead                 = { fg = "#282a3a", bg  = theme.yellow };
      LspReferenceWrite                = { bg = theme.yellow };
      DiffAdd                          = { fg = theme.lightgreen };
      DiffChange                       = { fg = theme.yellow };
      DiffDelete                       = { fg = theme.red };
      ActiveTabNum                     = { fg = theme.lightgreen, bg = theme.visualblack, style = 'bold' },
      InactiveTabNum                   = { fg = theme.red },
      TabLineSel                       = { fg = theme.lightgreen, bg = theme.visualblack, style = 'bold' },
      TabLineFill                      = { bg = theme.black },
      TabLine                          = { bg = theme.black, fg = theme.lightgrey },
      qfFileName                       = { fg = theme.white, style = 'bold' },
      Todo                             = { fg = theme.yellow, style = 'bold' },
      gitcommitType                    = { fg = theme.lightgreen };
      gitcommitBranch                  = { fg = theme.yellow, style = 'bold' };
    }
    return plugin_syntax
end

_G.async_load_plugin = vim.loop.new_async(vim.schedule_wrap(function ()
  local syntax = theme.load_plugin_syntax()
  for group,colors in pairs(syntax) do
    theme.highlight(group,colors)
  end
  async_load_plugin:close()
end))

function theme.colourscheme()
  vim.api.nvim_command('hi clear')
  if vim.fn.exists('syntax_on') then
    vim.api.nvim_command('syntax reset')
  end
  vim.o.background = 'dark'
  vim.o.termguicolors = true
  local syntax = theme.base_syntax()
  for group,colors in pairs(syntax) do
    theme.highlight(group,colors)
  end
  async_load_plugin:send()
end

theme.colourscheme()

return theme
