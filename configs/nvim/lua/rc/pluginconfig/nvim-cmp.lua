local cmp = require("cmp")
local snippy = require("snippy")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
  formatting = {
    format = require("lspkind").cmp_format({
      with_text = true,
      maxwidth = 50,
      menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        snippy = "[Snippet]",
        nvim_lua = "[NeovimLua]",
        path = "[Path]",
        omni = "[Omni]",
        spell = "[Spell]",
        emoji = "[Emoji]",
        calc = "[Calc]",
        rg = "[Rg]",
        treesitter = "[TS]",
        dictionary = "[Dictionary]",
        mocword = "[mocword]",
        cmdline_history = "[History]",
        tmux = "[tmux]",
      },
      before = require("tailwindcss-colorizer-cmp").formatter,
    }),
  },
  mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<Up>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      else
        vim.api.nvim_feedkeys(t("<Up>"), "n", true)
      end
    end, { "i" }),

    ["<Down>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        vim.api.nvim_feedkeys(t("<Down>"), "n", true)
      end
    end, { "i" }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if require("copilot.suggestion").is_visible() then
        require("copilot.suggestion").accept()
      elseif cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end, { "i", "s" }),
    --
    -- ["<S-Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif snippy.can_expand_or_advance() then
    --     snippy.previous()
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),

    ["<C-Down>"] = cmp.mapping(function(fallback)
      fallback()
    end, { "i", "s" }),

    ["<C-Up>"] = cmp.mapping(function(fallback)
      fallback()
    end, { "i", "s" }),

    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable,                     -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-q>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },

  snippet = {
    expand = function(args)
      require("snippy").expand_snippet(args.body)
    end,
  },

  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require("cmp-under-comparator").under,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "snippy" },
    { name = "path" },
    { name = "emoji",                  insert = true },
    { name = "nvim_lua" },
    { name = "nvim_lsp_signature_help" },
  }, {
    { name = "buffer" },
    { name = "calc" },
    { name = "treesitter" },
    { name = "dictionary" },
    { name = "mocword" },
    { name = "spell" },
    { name = "tmux" },
  }),

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

-- `/` cmdline setup.
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" },
      },
    },
  }),
})

vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
