lze.load {
  "telescope",
  event = "DeferredUIEnter",
  after = function()
    require('telescope').setup {}
  end
}
