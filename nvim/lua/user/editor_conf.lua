local utils = require('user.utils')

-- SET THE VIM GLOBAL SETTINGS --
utils.SetVimGlobal({
  loaded_netrw = 1,
  loaded_netrwPlugin = 1,
  mapleader = ',',
  -- netrw_banner = 0,
  -- netrw_winsize = 32,
  -- virtcolumn_char = '▕',
  virtcolumn_priority = 10,
})

-- SET THE VIM OPTIONAL SETTINGS --
local tab_size = 2;
utils.SetVimOptional({
  autoindent = true,
  breakindent = true,
  colorcolumn = '81',
  compatible = false,
  completeopt = {'menu', 'menuone', 'noselect'},
  cursorcolumn = true,
  cursorline = true,
  encoding = 'UTF-8',
  expandtab = true,
  guifont = 'JetBrainsMono Nerd Font Mono',
  hlsearch = false,
  ignorecase = true,
  list = true,
  listchars = { ['eol'] = '↴', ['space'] = '·' },
  mouse = 'a',
  number = true,
  relativenumber = true,
  shiftwidth = tab_size,
  showmatch = true,
  smartcase = true,
  smarttab = true,
  tabstop = tab_size,
  termguicolors = true,
  wrap = true,
})
