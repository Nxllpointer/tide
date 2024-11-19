lze.load {
  "blink-cmp",
  dep_of = "lspconfig",
  after = function()
    require("blink.cmp").setup {
      keymap = require("tide.mappings").blink(),
      trigger = { signature_help = { enabled = true } },
      -- accept = { auto_brackets = { enabled = true } },
    }
  end
}
