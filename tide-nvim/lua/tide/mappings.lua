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

return M
