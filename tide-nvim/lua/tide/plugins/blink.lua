return {
  "blink-cmp",
  event = { "LspAttach", "CmdlineEnter" },
  on_require = "blink.cmp",
  after = function()
    require("blink.cmp").setup {
      fuzzy = {
        prebuilt_binaries = {
          download = false
        }
      },

      keymap = require("tide.mappings").blink(),

      signature = { enabled = true },

      completion = {
        list = {
          selection = "manual";
        }
      },

      sources = {
        cmdline = {}
      }
    }
  end
}
