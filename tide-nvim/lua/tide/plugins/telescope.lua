return {
  "telescope",
  cmd = "Telescope",
  after = function()
    require('telescope').setup {}
  end
}
