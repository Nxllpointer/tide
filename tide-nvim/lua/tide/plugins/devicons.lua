return {
  "devicons",
  on_require = "nvim-web-devicons",
  after = function()
    require('nvim-web-devicons').setup {}
  end
}
