require("toggleterm").setup({
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.40
    end
  end,
  on_open = function()
    -- Prevent infinite calls from freezing neovim.
    -- Only set these options specific to this terminal buffer.
    vim.api.nvim_set_option_value("foldmethod", "manual", { scope = "local" })
    vim.api.nvim_set_option_value("foldexpr", "0", { scope = "local" })
  end,
  open_mapping = false, -- [[<c-\>]],
  hide_numbers = true,  -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = false,
  shading_factor = "1",   -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = "horizontal",
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell,  -- change the default shell
})

local Terminal = require("toggleterm.terminal").Terminal

local tig = Terminal:new({ cmd = "tig", hidden = true, direction = "float" })

function _tig_toggle()
  tig:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _tig_toggle()<CR>", { noremap = true, silent = true })

local trf = Terminal:new({ cmd = "trf", hidden = true, direction = "float" })

function _trf_toggle()
  trf:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>lua _trf_toggle()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>tt", ":ToggleTerm size=30<CR>")
