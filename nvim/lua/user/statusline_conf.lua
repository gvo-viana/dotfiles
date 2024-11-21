local lighten = require('tokyonight.util').lighten
local colors = require('tokyonight.colors').setup()

-- require('tokyonight').setup({})
require('tokyonight').setup({
  style = 'night',
  transparent = true,
  sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' },
  styles = {
    functions = { italic = true },
  },

  on_colors = function(colors)
    colors.comment = lighten(colors.comment, 0.8)
    colors.fg_gutter = lighten(colors.fg_gutter, 0.85)
    -- colors.bg_sidebar = colors.none
    colors.bg_sidebar = colors.bg
  end,

  on_highlights = function(highlights, colors)
    highlights.Pmenu.bg = colors.none
    highlights.PmenuSel.bg = colors.none
    highlights.PmenuSel.fg = colors.border_highlight
    highlights.PmenuSel.bold = true
    highlights.FloatBorder.bg = colors.none
    highlights.IndentBlanklineContextChar.fg = colors.border_highlight
  end,
})

local function fmt_datetime()
  return os.date('%d/%b')
end

local bubbles_theme = {
  normal = {
    a = { fg = colors.bg, bg = colors.magenta },
    b = { fg = colors.fg, bg = colors.dark3 },
    c = { fg = colors.fg, bg = colors.none },
  },
  insert = {
    a = { fg = colors.bg, bg = colors.green1 },
  },
  visual = {
    a = { fg = colors.bg, bg = lighten(colors.yellow, 0.7) },
  },
  replace = {
    a = { fg = colors.bg, bg = colors.red1 },
  },
  command = {
    a = { fg = colors.bg, bg = colors.blue6 },
  },
  terminal = {
    a = { fg = colors.bg, bg = colors.blue },
  },
  inactive = {
    a = { fg = colors.fg, bg = colors.dark3 },
    b = { fg = colors.fg, bg = colors.dark3 },
    c = { fg = colors.fg, bg = colors.none },
  },
}
local sep = { left = '', right = ''}

require('lualine').setup({
  options = {
    -- color = { gui = 'bold,italic' },
    component_separators = { left = '', right = '', },
    section_separators = { left = '', right = '', },
    theme = bubbles_theme,
    always_divide_middle = false,
  },

  sections = {
    lualine_a = {{ 'mode', separator = sep, },},
    lualine_b = {{ fmt_datetime, separator = { right = sep.right }, },},
    lualine_c = {{'branch'}, { 'diff' }, { 'diagnostics'},},
    lualine_x = {{ 'encoding' }, { 'fileformat' }, { 'filetype'}, },
    lualine_y = {{ 'progress', separator = { left = sep.left },},},
    lualine_z = {{ 'location', separator = sep, },},
  },

  inactive_sections = {
    lualine_a = {{},},
    lualine_b = {{},},
    lualine_c = {{},},
    lualine_x = {{},},
    lualine_y = {{},},
    lualine_z = {{},},
  },

  tabline = {
    lualine_a = {
      {
        'buffers',
        mode = 0,
        padding = 2,
        separator = sep,
        symbols = { modified = ' 🡣', alternate_file = '' },
        use_mode_colors = true,
        max_length = 100,
        fmt = function (str)
          return str:sub(1, 15)
        end
      },
    },
    lualine_b = {{},},
    lualine_c = {{},},
    lualine_x = {{},},
    lualine_y = {{},},
    lualine_z = {
      {
        'buffers',
        icons_enabled = false,
        mode = 3,
        separator = sep,
        show_modified_status = false,
        symbols = { modified = '', alternate_file = '', directory = '', },
        use_mode_colors = true,
      },
    },
  },

  extensions = { 'nvim-tree' },
})
