return {
  "debugmaster",
  on_require = "debugmaster",
  after = function()
    local dm = require("debugmaster")
    dm.plugins.cursor_hl.enabled = true
  end
}
