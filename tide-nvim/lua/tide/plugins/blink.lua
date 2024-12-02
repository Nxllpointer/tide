return {
  "blink-cmp",
  event = "LspAttach",
  on_require = "blink.cmp",
  after = function()
    require("blink.cmp").setup {
      keymap = require("tide.mappings").blink(),
      trigger = { signature_help = { enabled = true } },
      windows = {
        autocomplete = {
          selection = "manual"
        }
      }
    }
  end
}
