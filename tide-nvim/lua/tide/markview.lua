lze.load {
  "markview",
  ft = { "markdown" }, -- Lazy loading is discouraged but loading times are slow
  after = function()
    require("markview").setup {
      buf_ignore = {}
    }
  end
}
