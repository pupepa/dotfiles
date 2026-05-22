return {
  -- Hlsearch Lens for Neovim
  -- https://github.com/kevinhwang91/nvim-hlslens
  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    config = function()
      require("hlslens").setup({})

      vim.keymap.set("n", "n", function()
        local ok, err = pcall(function()
          vim.cmd.normal({ args = { vim.v.count1 .. "n" }, bang = true })
        end)
        if ok then
          require("hlslens").start()
        else
          -- エラーメッセージを表示（オプション）
          -- vim.notify("End of bottom", vim.log.levels.WARN)
        end
      end)

      vim.keymap.set("n", "N", function()
        local ok, err = pcall(function()
          vim.cmd.normal({ args = { vim.v.count1 .. "N" }, bang = true })
        end)
        if ok then
          require("hlslens").start()
        else
          -- vim.notify(err, vim.log.levels.WARN)
        end
      end)

      local hlslens = require("hlslens")
      vim.keymap.set("n", "*", function()
        local current_word = vim.fn.expand("<cword>")
        vim.fn.histadd("search", current_word)
        vim.fn.setreg("/", current_word)
        vim.opt.hlsearch = true
        hlslens.start()
      end)

      vim.keymap.set("n", "#", function()
        local current_word = vim.fn.expand("<cword>")
        vim.api.nvim_feedkeys(":%s/" .. current_word .. "//g", "n", false)
        -- :%s/word/CURSOR/g
        local ll = vim.api.nvim_replace_termcodes("<Left><Left>", true, true, true)
        vim.api.nvim_feedkeys(ll, "n", false)
        vim.opt.hlsearch = true
        hlslens.start()
      end)

      local function getVisualSelection()
        vim.cmd.normal({ args = { '"vy' }, bang = true, mods = { noautocmd = true } })
        local text = vim.fn.getreg("v")
        vim.fn.setreg("v", {})

        if #text > 0 then
          return text
        else
          return ""
        end
      end

      vim.keymap.set("v", "*", function()
        local current_word = getVisualSelection()
        current_word = vim.fn.substitute(vim.fn.escape(current_word, "\\"), "\\n", "\\\\n", "g")
        vim.fn.histadd("search", current_word)
        vim.fn.setreg("/", current_word)
        vim.opt.hlsearch = true
        hlslens.start()
      end)

      vim.keymap.set("v", "#", function()
        local current_word = getVisualSelection()
        current_word = vim.fn.substitute(vim.fn.escape(current_word, "\\"), "\\n", "\\\\n", "g")
        vim.api.nvim_feedkeys(":%s/" .. current_word .. "//g", "n", false)
        -- :%s/word/CURSOR/g
        local ll = vim.api.nvim_replace_termcodes("<Left><Left>", true, true, true)
        vim.api.nvim_feedkeys(ll, "n", false)
        vim.opt.hlsearch = true
        hlslens.start()
      end)
    end,
    -- config = function()
    --   require("rc/pluginconfig/nvim-hlslens")
    -- end,
  },
}
