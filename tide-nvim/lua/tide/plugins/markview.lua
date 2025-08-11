return {
  "markview",
  ft = { "markdown", "typst" }, -- Lazy loading is discouraged but loading times are slow
  after = function()
    require("markview").setup {
      typst = {
        enable = true,
        code_blocks = {
          style = "simple"
        }
      },
      markdown = { enable = true },
      latex = { enable = false },
      yaml = { enable = false },
    }
  end
}
