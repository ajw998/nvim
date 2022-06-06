-- require "nvim-treesitter.highlight"
local theme = require'color.nord'.colors

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
    PMenu        = { fg = theme.grey6, bg="NONE" };
    PMenuSel     = { fg = theme.grey13, bg=theme.yellow };
    Comment      = { fg = theme.grey6 };
    SignColumn   = { fg = "NONE", bg = "NONE" };
    ColorColumn  = { fg = "NONE", bg = "NONE" };
    Cursor       = { fg = theme.grey1 };
    CursorLineNR = { fg = theme.yellow };
    Identifier   = { fg = theme.red };
    Keyword      = { fg = theme.red };
    Title        = { fg = theme.grey1 };
    LineNr       = { fg = theme.grey10 };
    MatchParen   = { fg = theme.red, style="underline" };
    NonText      = { fg = theme.grey11 };
    Number       = { fg = theme.purple };
    Operator     = { fg = theme.red };
    Statement    = { fg = theme.red };
    StatusLine   = { fg = theme.grey1, bg=theme.grey11 };
    String       = { fg = theme.yellow };
    VertSplit    = { fg = theme.grey14, bg = "NONE" };
    Visual       = { bg = "#323343" };
}
    return base_syntax
end

function theme.load_plugin_syntax()
    local plugin_syntax = {
      TSSymbol                         = { fg = theme.red };
      TSPunctBracket                   = { fg = theme.grey1 };
      TSBoolean                        = { fg = theme.purple };
      TSComment                        = { fg = theme.grey6 };
      TSString                         = { fg = theme.yellow };
      TSError                          = { fg = theme.red };
      TSConstructor                    = { fg = theme.green };
      TSAnnotation                     = { fg = theme.grey6 };
      TSNumber                         = { fg = theme.purple };
      TSCharacter                      = { fg = theme.purple };
      TSParameter                      = { fg = theme.grey1 };
      TSConstBuiltin                   = { fg = theme.cyan };
      TSFunction                       = { fg = theme.green };
      TSProperty                       = { fg = theme.grey1 };
      TSLiteral                        = { fg = theme.grey1 };
      TSType                           = { fg = theme.cyan };
      TSTypeBuiltin                    = { fg = theme.cyan };
      TSTitle                          = { fg = theme.grey1 };
      DiagnosticError                  = { fg = theme.red };
      DiagnosticWarn                   = { fg = theme.orange };
      DiagnosticHint                   = { fg = theme.cyan };
      LspDiagnosticsVirtualTextWarning = { fg = theme.orange };
      LspDiagnosticsVirtualTextError   = { fg = theme.red };
      LspReferenceText                 = { fg = theme.grey13,  bg = theme.yellow };
      LspReferenceRead                 = { fg = theme.grey13, bg  = theme.yellow };
      LspReferenceWrite                = { bg = theme.yellow };
      DiffAdd                          = { fg = theme.green };
      DiffChange                       = { fg = theme.yellow };
      DiffDelete                       = { fg = theme.red };
      ActiveTabNum                     = { fg = theme.green, bg = theme.visualblack, style = 'bold' },
      InactiveTabNum                   = { fg = theme.red },
      TabLineSel                       = { fg = theme.green, bg = theme.visualblack, style = 'bold' },
      TabLineFill                      = { bg = theme.black },
      TabLine                          = { bg = theme.black, fg = theme.grey6 },
      qfFileName                       = { fg = theme.grey1, style = 'bold' },
      Todo                             = { fg = theme.yellow, style = 'bold' },
      gitcommitType                    = { fg = theme.green },
      gitcommitBranch                  = { fg = theme.yellow, style = 'bold' },
      cType                            = { fg = theme.cyan, style = 'bold' },
      cConstant                        = { fg = theme.red },
      cInclude                         = { fg = theme.red },
      cBracket                         = { fg = theme.red },
      cPragma                          = { fg = theme.red },
      cPreProc                         = { fg = theme.red },
      cPreCondit                       = { fg = theme.red },
      cBlock                           = { fg = theme.yellow };
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
