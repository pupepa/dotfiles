local augend = require("dial.augend")

require("dial.config").augends:register_group({
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.integer.alias.binary,
    augend.date.new({
      pattern = "%Y/%m/%d",
      default_kind = "day",
      clamp = true,
      end_sensitive = true,
    }),
    augend.date.new({
      pattern = "%Y-%m-%d",
      default_kind = "day",
      clamp = true,
      end_sensitive = true,
    }),
    augend.date.new({
      pattern = "%Y年%-m月%-d日",
      default_kind = "day",
      clamp = true,
      end_sensitive = true,
    }),
    augend.date.new({
      pattern = "%-m月%-d日",
      default_kind = "day",
      clamp = true,
      end_sensitive = true,
    }),
    augend.date.new({
      pattern = "%-m月%-d日(%J)",
      default_kind = "day",
      clamp = true,
      end_sensitive = true,
    }),
    augend.date.new({
      pattern = "%-m月%-d日（%J）",
      default_kind = "day",
      clamp = true,
      end_sensitive = true,
    }),
    augend.date.new({
      pattern = "%m/%d",
      default_kind = "day",
      only_valid = true,
      word = true,
      clamp = true,
      end_sensitive = true,
    }),
    augend.date.new({
      pattern = "%Y/%m/%d (%J)",
      default_kind = "day",
      clamp = true,
      end_sensitive = true,
    }),
    augend.date.new({
      pattern = "%Y/%m/%d（%J）",
      default_kind = "day",
      clamp = true,
      end_sensitive = true,
    }),
    augend.date.new({
      pattern = "%H:%M",
      default_kind = "min",
      only_valid = true,
      word = true,
    }),
    augend.constant.new({
      elements = { "true", "false" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "True", "False" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "&&", "||" },
      word = false,
      cyclic = true,
    }),
    augend.constant.alias.ja_weekday,
    augend.constant.alias.ja_weekday_full,
    augend.hexcolor.new({ case = "lower" }),
    augend.semver.alias.semver,
  },

  swift = {
    augend.constant.new({
      elements = { "XCTAssertTrue", "XCTAssertFalse" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "XCTAssertNil", "XCTAssertNotNil" },
      word = true,
      cyclic = true,
    }),
  },
})

vim.keymap.set("n", "<C-a>", function()
  require("dial.map").manipulate("increment", "normal")
end)
vim.keymap.set("n", "<C-x>", function()
  require("dial.map").manipulate("decrement", "normal")
end)
vim.keymap.set("n", "+", function()
  require("dial.map").manipulate("increment", "normal")
end)
vim.keymap.set("n", "-", function()
  require("dial.map").manipulate("decrement", "normal")
end)
vim.keymap.set("v", "<C-a>", function()
  require("dial.map").manipulate("increment", "visual")
end)
vim.keymap.set("v", "<C-x>", function()
  require("dial.map").manipulate("decrement", "visual")
end)
vim.keymap.set("v", "g<C-a>", function()
  require("dial.map").manipulate("increment", "gvisual")
end)
vim.keymap.set("v", "g<C-x>", function()
  require("dial.map").manipulate("decrement", "gvisual")
end)

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "swift" },
  callback = function()
    vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal("swift"))
  end,
})
