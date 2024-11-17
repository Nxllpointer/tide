lze.load {
  "blink-cmp",
  dep_of = "lspconfig",
  after = function()
    require("blink.cmp").setup {
      keymap = {
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
      },
      trigger = { signature_help = { enabled = true } },
      accept = { auto_brackets = { enabled = true } },
    }
  end
}
