return {
  "gitsigns",
  event = "DeferredUIEnter",
  after = function ()
    require('gitsigns').setup {
      signcolumn = false,
      numhl = true
    }
  end
}
