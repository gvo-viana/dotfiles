local vim = vim

local utils = {
  SetVimGlobal = function(global_table)
    for k, v in pairs(global_table) do
      vim.g[k] = v
    end
  end,

  SetVimOptional = function(optional_table)
    for k, v in pairs(optional_table) do
      vim.opt[k] = v
    end
  end
  ,
  SetVimKeymaps = function(keymap_table)
    local SetVimKeymap = function(mode, lhs, rhs, desc)
      local key_opts = { desc = desc }
      vim.keymap.set(mode, lhs, rhs, key_opts)
    end

    for _, t in ipairs(keymap_table) do
      SetVimKeymap(t.mode, t.lhs, t.rhs, t.desc)
    end
  end
  ,
  PlugPlugins = function(plugins_path,  plugins_table)
    vim.call('plug#begin', plugins_path)
    local plug = vim.fn['plug#']
    for _, plugin in ipairs(plugins_table) do
      if (#plugin == 2) then
        plug(plugin[1], plugin[2])
      else
        plug(plugin[1])
      end
    end
    vim.call('plug#end')
  end
  ,
  SetDiagnosticSigns = function(sign_table)
    for _, t in ipairs(sign_table) do
      vim.fn.sign_define(
        t.name,
        {
          texthl = t.name,
          text = t.text,
          numhl = '',
        }
      )
    end
  end,
}

return utils
