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

function M.other()
  return {

  }
end

return M
