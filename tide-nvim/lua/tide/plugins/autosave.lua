return {
  "auto-save",
  cmd = "ASToggle",
  event = { "InsertLeave", "TextChanged" },
  after = function()
    require("auto-save").setup {
      debounce_delay = 10
    }
  end
}
