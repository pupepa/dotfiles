return {
  -- A completion plugin for neovim coded in Lua.
  -- https://github.com/hrsh7th/nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- nvim-cmp source for displaying function signatures with the current parameter emphasized:
      -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
      "hrsh7th/cmp-nvim-lsp-signature-help",
      -- nvim-cmp source for buffer words.
      -- https://github.com/hrsh7th/cmp-buffer
      "hrsh7th/cmp-buffer",
      -- nvim-cmp source for filesystem paths.
      -- https://github.com/hrsh7th/cmp-path
      "hrsh7th/cmp-path",
      -- nvim-cmp source for neovim Lua API.
      -- https://github.com/hrsh7th/cmp-nvim-lua
      "hrsh7th/cmp-nvim-lua",
      -- nvim-cmp source for emojis.
      -- https://github.com/hrsh7th/cmp-emoji
      "hrsh7th/cmp-emoji",

      -- nvim-cmp source for math calculation.
      -- https://github.com/hrsh7th/cmp-calc
      "hrsh7th/cmp-calc",

      -- cmp source for treesitter
      -- https://github.com/ray-x/cmp-treesitter
      "ray-x/cmp-treesitter",

      "dcampos/cmp-snippy",

      "roobert/tailwindcss-colorizer-cmp.nvim",

      -- nvim-cmp source for vim's cmdline
      -- https://github.com/hrsh7th/cmp-cmdline
      { "hrsh7th/cmp-cmdline" },

      "cmp-nvim-lsp",

      -- nvim-cmp comparator function for completion items that start with one or more underlines
      -- https://github.com/lukas-reineke/cmp-under-comparator
      {
        "lukas-reineke/cmp-under-comparator",
      },

      {
        "dmitmel/cmp-cmdline-history",
      },
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("snippy")

      local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end

      local has_words_before = function()
        local unpack = unpack or table.unpack ---@diagnostic disable-line: deprecated
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      return {
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
              emoji = "[Emoji]",
              calc = "[Calc]",
              rg = "[Rg]",
              treesitter = "[TS]",
              dictionary = "[Dictionary]",
              cmdline_history = "[History]",
            },
            before = require("tailwindcss-colorizer-cmp").formatter,
          }),
        },
        mapping = {
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ---@diagnostic disable-next-line: unused-local
          ["<Up>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
              vim.api.nvim_feedkeys(t("<Up>"), "n", true)
            end
          end, { "i" }),

          ---@diagnostic disable-next-line: unused-local
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
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-Down>"] = cmp.mapping(function(fallback)
            fallback()
          end, { "i", "s" }),

          ["<C-Up>"] = cmp.mapping(function(fallback)
            fallback()
          end, { "i", "s" }),

          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-y>"] = cmp.config.disable,
          ["<C-q>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
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
          { name = "lazydev", group_index = 0 },
          { name = "copilot" },
          { name = "snippy" },
          { name = "path" },
          { name = "emoji", insert = true },
          { name = "nvim_lua" },
          { name = "nvim_lsp_signature_help" },
        }, {
          { name = "buffer" },
          { name = "calc" },
          { name = "treesitter" },
        }),

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)

      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "nvim_lsp_document_symbol" },
          { name = "buffer" },
        }, {}),
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "c" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "c" }),

          ["<C-y>"] = { c = cmp.mapping.confirm({ select = false }) },
          ["<C-q>"] = { c = cmp.mapping.abort() },
        },
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" }, { { name = "cmdline_history" } } }),
      })

      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })
    end,
  },

  {
    "dcampos/cmp-snippy",
    lazy = true,
    dependencies = { "dcampos/nvim-snippy" },
  },

  -- nvim-cmp source for neovim builtin LSP client
  -- https://github.com/hrsh7th/cmp-nvim-lsp
  { "hrsh7th/cmp-nvim-lsp", lazy = true },

  -- https://github.com/pupepa/copilot-cmp
  {
    "pupepa/copilot-cmp",
    lazy = true,
    opts = {},
  },
}
