return {
  "auto-save",
  cmd = "ASToggle",
  event = { "InsertLeave", "TextChanged" },
  after = function()
    require("auto-save").setup {}
  end
}
