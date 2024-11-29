return {
  "blink-cmp",
  event = "LspAttach",
  on_require = "blink.cmp",
  after = function()
    require("blink.cmp").setup {
      keymap = require("tide.mappings").blink(),
      trigger = { signature_help = { enabled = true } },
      -- accept = { auto_brackets = { enabled = true } },
    }
  end
}
