return {
  "which-key",
  event = "DeferredUIEnter",
  on_require = "which-key",
  after = function()
    local which_key = require("which-key")
    which_key.setup {}
    which_key.add(require("tide.mappings").other())
  end
}
