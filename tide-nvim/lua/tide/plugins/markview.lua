return {
  "markview",
  ft = { "markdown" }, -- Lazy loading is discouraged but loading times are slow
  after = function()
    require("markview").setup {
      preview = {
        ignore_buftypes = {} -- Show in hover window
      },
      latex = { enable = false },
      typst = { enable = false },
      yaml = { enable = false }
    }
  end
}
