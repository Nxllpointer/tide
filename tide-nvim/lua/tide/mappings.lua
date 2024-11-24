vim.g.mapleader = " "

local M = {}

function M.blink()
  return {
    preset = "enter",
    ['<C-space>'] = { 
      'show',
      require("blink.cmp.trigger.signature").show,
      'show_documentation', 'hide_documentation'
    },
    ['<C-e>'] = { 
      vim.schedule_wrap(require("blink.cmp.trigger.signature").hide), 
      'hide'
    },
  }
end

function M.neotree()
  return {
    ["<space>"] = "none", -- Fix for using space as <leader>
    ["n"] = "new_typst_note" -- Copt the typst template to the specified location in the current context
  }
end

function M.preview(buffer)
  local preview = require("tide.preview")
  return {
    mode = "n",
    buffer = buffer,
    { "<leader>p", preview.start, desc = "Preview > Start" },
    { "<leader>P", preview.kill, desc = "Preview > Stop" },
    { "<leader>m", preview.pin, desc = "Preview > Pin Main File" },
    { "<leader>M", preview.unpin, desc = "Preview > Unpin Main File" },
  }
end

function M.typst(buffer)
  return {
    mode = "n",
    buffer = buffer,
    { 
      "<leader>n",
      function() 
        local tideproject = require("tide.tideproject").current()
        if tideproject ~= nil then
          tideproject:new_rnote_doc()
        end
      end,
      desc = "New Rnote Document"
    }
  }
end

function M.other()
  return {
    { "<leader><tab>", vim.cmd.Neotree, desc = "Open File Tree" }
  }
end

return M
