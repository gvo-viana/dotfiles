local utils = require('user.utils')

utils.PlugPlugins(
  '~/.config/nvim/lua/user/plugged',
  {
    { 'folke/tokyonight.nvim', { ['branch'] = 'main' } }, -- colortheme
    { 'kyazdani42/nvim-web-devicons' }, -- modern file icons
    { 'kyazdani42/nvim-tree.lua' }, -- file explorer
    { 'norcalli/nvim-colorizer.lua' }, -- render colors in the editor
    { 'numToStr/Comment.nvim' }, -- tool to (un)comment block of codes
    { 'nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' } }, -- parser
    { 'HiPhish/rainbow-delimiters.nvim' }, -- color the data containers logically
    { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
    { 'xiyaowong/virtcolumn.nvim'}, -- render the 80-column vertical line
    { 'windwp/nvim-autopairs' }, -- autocomplete data containers
    { 'nvim-lualine/lualine.nvim' }, --render both the status and tab lines
    { 'chrisbra/unicode.vim' }, -- tool to search and insert unicodes
    { 'tpope/vim-surround' }, -- tool to surround text with containers
    { 'lewis6991/spellsitter.nvim' }, -- a check speller.
    { 'mcauley-penney/tidy.nvim' }, -- remove trailing spaces on saving.
    { 'neovim/nvim-lspconfig' }, -- a linter server
    { 'williamboman/mason.nvim' }, -- a linter server manager.
    { 'williamboman/mason-lspconfig.nvim' }, -- integrate mason with lspconfig.
    { 'hrsh7th/cmp-nvim-lsp' }, -- module to integrate cmp with lspconfig.
    { 'hrsh7th/cmp-buffer' }, -- buffer module of cmp.
    { 'hrsh7th/cmp-path' }, -- path module of cmp.
    { 'hrsh7th/cmp-cmdline' }, -- command line of cmp.
    { 'hrsh7th/nvim-cmp' }, -- autocompletion plugin.
    { 'L3MON4D3/LuaSnip', { ['do'] = 'make install_jsregexp', ['tag'] = 'v2.*' } }, -- lua code snippets.
    { 'saadparwaiz1/cmp_luasnip' }, -- module to integrate luasnip with cmp.
    { 'rafamadriz/friendly-snippets' }, -- vscode code snippets.
    { 'sbdchd/neoformat' }, -- a language formatter.
    { 'folke/zen-mode.nvim' }, -- editor zen mode.
    { 'folke/twilight.nvim' }, -- a dimmer of zen mode.
    { 'tpope/vim-repeat'}, -- extend the "." command.
    { 'mg979/vim-visual-multi' }, -- a one-shot multi selector.
    { 'vim-scripts/loremipsum' }, -- a dummy text generator.
    { 'sQVe/sort.nvim' }, -- enhance the sort tool.
  }
)

-- REQUIRING THE PLUGINS --

require('colorizer').setup({})
require('Comment').setup({})
require('nvim-autopairs').setup({})
require('tidy').setup({})
require('sort').setup({})

require('spellsitter').setup({
  enable = true,
})

require('nvim-tree').setup({
  view = { width = 40, },
})

require('ibl').setup({
  indent = { char = '│' },
  scope = { enabled = true },
})

require("nvim-treesitter.install").compilers = {"clang", "gcc"}
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'c', 'cpp', 'css', 'fish', 'html', 'javascript', 'json', 'latex',
    'lua', 'python', 'query', 'rust', 'toml', 'typescript', 'vim', 'yaml',
  },

  sync_install = true,
  auto_install = true,
  ignore_install = {},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  rainbow = {
    enable = false,
    -- disable = { 'jsx', 'cpp' }, -- files to disable.
    extended_mode = true, -- highlight other symbols other than pairs.
    max_file_lines = nil
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  modules = {},
})

require('twilight').setup({
  dimming = {
    alpha = 0.3,
    color = { 'Normal', '#ffffff' },
    term_bg = '#000000',
    inactive = false,
  },
  context = 15,
  treesitter = true,
})

require('zen-mode').setup({
  window = {
    backdrop = 0,
    width = 0.7,
    options = {
      -- cursorcolumn = false, -- disable cursor column
      -- cursorline = false, -- disable cursorline
      -- foldcolumn = '0', -- disable fold column
      -- list = false, -- disable whitespace characters
      -- number = false, -- disable number column
      -- relativenumber = false, -- disable relative numbers
      -- signcolumn = 'no', -- disable signcolumn
    },
  },
  twilight = { enabled = true, },
})
