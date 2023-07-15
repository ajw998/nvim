local _cmp, cmp = pcall(require, "cmp")

if not _cmp then
  return
end

local lspkind = require("lspkind")

-- Uses Fira Code Nerd Font Mono
local kinds = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "",
}

cmp.setup {
  enabled = function()
    local in_prompt = vim.api.nvim_buf_get_option(0, "buftype") == "prompt"
    if in_prompt then
      return false
    end
    local context = require "cmp.config.context"
    return not (context.in_treesitter_capture "comment" == true or context.in_syntax_group "Comment")
  end,
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
  confirmation = {
    get_commit_characters = function()
      return {}
    end,
  },
  view = {
    entries = "custom",
  },
  completion = {
    completeopt = "menu,menuone,noinsert",
    keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
    keyword_length = 1,
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },
  formatting = {
    format = lspkind.cmp_format {
      mode = 'symbol_text',
      symbol_map = kinds
    }
  },
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),

    ["<c-space>"] = cmp.mapping {
      i = cmp.mapping.complete(),
      c = function(
         _ --[[fallback]]
      )
        if cmp.visible() then
          if not cmp.confirm { select = true } then
            return
          end
        else
          cmp.complete()
        end
      end,
    },
    ["<tab>"] = cmp.config.disable,
    ["<C-k>"] = cmp.mapping.complete({ reason = cmp.ContextReason.Auto })
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp", keyword_length = 2 },
    -- { name = "nvim_lua" },
    -- { name = "luasnip" },
    -- { name = "path" },
    { name = "buffer", keyword_length = 2 },
  }),
  preselect = cmp.PreselectMode.None,
  sorting = { 
    comparator = { 
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.kind,
    }
  }
}

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
