return {
  -- 🏙 A clean, dark Neovim theme written in Lua, with support for lsp, treesitter and lots of plugins. Includes additional themes for Kitty, Alacritty, iTerm and Fish.
  -- https://github.com/folke/tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        transparent = true,
        on_colors = function() end,
        on_highlights = function(highlights, colors)
          -- Markdownの見出しの色をH1〜H6まで全てH1と同じ色に揃える
          for level = 2, 6 do
            highlights["@markup.heading." .. level .. ".markdown"] = { link = "@markup.heading.1.markdown" }
          end
        end,
      })

      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
