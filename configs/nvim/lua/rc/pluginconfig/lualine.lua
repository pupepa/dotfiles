-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+
--
local function selectionCount()
  local mode = vim.fn.mode()
  local start_line, end_line, start_pos, end_pos

  -- 選択モードでない場合には無効
  if not (mode:find("[vV\22]") ~= nil) then
    return ""
  end

  start_line = vim.fn.line("v")
  end_line = vim.fn.line(".")

  local lines = math.abs(end_line - start_line) + 1
  return tostring(lines) .. " lines"
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "|", right = "|" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = {
      { selectionCount },
    },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
