require('user.editor_conf')
require('user.plug_conf')
require('user.statusline_conf')
require('user.lsp_conf')
require('user.keymaps')

vim.cmd([[
  colorscheme tokyonight
  filetype plugin on
  " highlight ColorColumn guibg = #bb9af7ee
  highlight ColorColumn guibg = #4a4d6c
  syntax enable
]])
