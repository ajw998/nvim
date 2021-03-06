local _cmp, cmp = pcall(require, "cmp")

if not _cmp then
    return
end

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local kinds = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "ﰕ",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "廓",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
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
        fields = { "kind", "abbr", "menu" },
        format = function(_, vim_item)
            vim_item.menu = vim_item.kind
            vim_item.kind = kinds[vim_item.kind]
            return vim_item
        end,
    },
    mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
	    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
	    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
	    ["<C-f>"] = cmp.mapping.scroll_docs(4),
	    ["<C-e>"] = cmp.mapping.abort(),
	    ["<c-y>"] = cmp.mapping(
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
    },
    sources = {
        { name = "nvim_lsp", keyword_length = 3 },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "buffer", keyword_length = 5 },
    },
    preselect = cmp.PreselectMode.None,
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

