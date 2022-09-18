_G.fzf_menu = function(opts)
  require('fzf-lua').fzf_exec(function(fzf_cb)
    local config_file = '~/.fzf-launcher'
    local config_file_path = vim.fn.fnamemodify(vim.fn.expand(config_file), ':p')
    local list = vim.fn.map(vim.fn.readfile(config_file_path), function(_, line)
      return vim.fn.split(line, '\t')
    end)
    local table = {}

    for _, v in ipairs(list) do
      table[v[1]] = v[2]
    end

    for key, value in pairs(table) do
      fzf_cb(key .. '	' .. value)
    end
    fzf_cb()
  end, {
  actions = {
    ['default'] = function(selected, opts)
      local command = vim.fn.split(selected[1], '	')
      vim.cmd(command[2])
    end
  }
})
end

vim.keymap.set('n', '<Space>a', _G.fzf_menu)
