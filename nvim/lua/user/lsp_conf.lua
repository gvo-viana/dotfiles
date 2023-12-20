local utils = require('user.utils')
local vim = vim

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})

require('mason').setup({
  ui = {
    icons = {
      package_installed = '🗸 ',
      package_pending = '🡢 ',
      package_uninstalled = '⛌ ',
    },
  },
})
require('mason-lspconfig').setup({})

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

local linters = {
  'angularls',
  'cssls',
  'html',
  'lua_ls',
  'pylsp',
  'tsserver',
  'vimls',
}

for _, linter in ipairs(linters) do
  if (linter == 'lua_ls') then
    lspconfig[linter].setup({
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
        },
      },
    })
  elseif (linter == 'angularls') then
    local ngSeverPath = '/usr/lib/node_modules/@angular/language-server/bin/ngserver'
    local cmd = {
      ngSeverPath,
      "--ngProbeLocations",
      ngSeverPath,
      "--tsProbeLocations",
      ngSeverPath ,
      "--stdio",
    }
    lspconfig[linter].setup({
      cmd = cmd,
      on_new_config = function(new_config, new_root_dir)
          new_config.cmd = cmd
      end
    })
  else
    lspconfig[linter].setup({})
  end
end

require('luasnip.loaders.from_vscode').lazy_load()
local cmp = require('cmp')
local luasnip = require('luasnip')
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
},
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp', keyword_length = 1},
    {
      name = 'buffer', keyword_length = 3,
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    {name = 'luasnip', keyword_length = 2},
  },
  window = {
    documentation = cmp.config.window.bordered({
      -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
      winhighlight = 'FloatBorder:FloatBorder,Normal:None',
    }),
    completion = cmp.config.window.bordered({
      winhighlight = 'FloatBorder:FloatBorder,Normal:None,CursorLine:PmenuSel',
    }),
},
  formatting = {
    fields = { 'menu', 'abbr', 'kind' },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'LSP',
        luasnip = 'SNIP',
        buffer = 'BUFF',
        path = 'PATH',
        cmdline = 'CMD',
      }
      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    ['<C-f>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1
      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),

  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'cmdline'},
    { name = 'path'},
  },
  })

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })

utils.SetDiagnosticSigns({
  { name = 'DiagnosticSignError', text = '󰅖' },
  { name = 'DiagnosticSignWarn', text = '‼' },
  { name = 'DiagnosticSignHint', text = '' },
  { name = 'DiagnosticSignInfo', text = '🛈 ' },
})

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = 'rounded' }
)

local formatters = {
  css = 'prettier',
  html = 'prettier',
  javascript = 'prettier',
  lua = 'stylua',
  python = 'black',
  typescript = 'prettier',
}

for l, f in pairs(formatters) do
  vim.g['neoformat_enabled_' .. l] = { f }
end
