return {
  "autopairs",
  event = "InsertEnter",
  after = function()
    require("nvim-autopairs").setup {}
  end
}
