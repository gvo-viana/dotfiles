local utils = require('user.utils')

utils.SetVimKeymaps({
  {
    mode = {'n', 'i', 'x'},
    lhs = '<c-s>', rhs = '<cmd>write<cr>',
    desc = 'Save',
  },
  --[[ {
    mode = {'n', 'i'},
    lhs = '<c-r>', rhs = '<cmd>source<cr>',
    desc = 'Reload the file'
  }, ]]
  {
    mode = {'n', 'i'},
    lhs = '<c-x>', rhs = '<cmd>quitall<cr>',
    desc = 'Quit neovim'
  },
  {
    mode = {'n', 'x'},
    lhs = '<leader>c', rhs = '"+y',
    desc = 'Copy the selection to the clipborad'
  },
  {
    mode = {'n', 'x'},
    lhs = '<leader>v', rhs = '"+p',
    desc = 'Past the selection from the clipborad'
  },
  {
    mode = {'n', 'x'},
    lhs = 'x', rhs = '"_x',
    desc = 'Delete a selection withou making a copy'
  },
  {
    mode = {'n', 'x'},
    lhs = '<leader>a', rhs = '<cmd>keepjumps normal! ggVG<cr>',
    desc = 'Copy all in the buffer'
  },
  {
    mode = {'n', 'i'},
    lhs = '<F7>', rhs = '<cmd>NvimTreeToggle<cr>',
    desc = 'Toggle NvimTree'
  },
  {
    mode = {'n', 'i'},
    lhs = '<C-Right>', rhs = '<C-w><Right>',
    desc = 'Switch between the NvimTree and the editor'
  },
  {
    mode = {'n', 'i'},
    lhs = '<C-Left>', rhs = '<C-w><Left>',
    desc = 'Switch between the NvimTree and the editor'
  },
  {
    mode = {'n', 'i'},
    lhs = '<A-n>', rhs = '<cmd>bnext<cr>',
    desc = 'Move to the next buffer'
  },
  {
    mode = {'n', 'i'},
    lhs = '<A-p>', rhs = '<cmd>bprevious<cr>',
    desc = 'Move to the previous buffer'
  },
  {
    mode = {'n', 'i'},
    lhs = '<leader>us', rhs = '<cmd>UnicodeSearch!',
    desc = 'Search an Unicode by a given word'
  },
  {
    mode = {'n', 'i'},
    lhs = '<leader>en', rhs = '<cmd>set spell spelllang=en_us<cr>',
    desc = 'Launch the english spell check'
  },
  {
    mode = {'n', 'i'},
    lhs = '<leader>pt', rhs = '<cmd>set spell spelllang=pt_br<cr>',
    desc = 'Launch the portuguese spell check'
  },
  {
    mode = {'n', 'i'},
    lhs = '<leader>zm', rhs = '<cmd>ZenMode<cr>',
    desc = 'Launch the ZenMode'
  },
  {
    mode = {'n', 'i'},
    lhs = '<leader>tl', rhs = '<cmd>Twilight<cr>',
    desc = 'Toogle Twilight'
  },
  -- {
  --   mode = 'n',
  --   lhs = '<leader>bd', rhs = '<cmd>Bdelete<cr>',
  --   desc = 'Close and remove the context buffer'
  -- },
})
