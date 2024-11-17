lze.load {
  "catppuccin",
  colorscheme = {
    "catppuccin",
    "catppuccin-latte",
    "catppuccin-frappe",
    "catppuccin-macchiato",
    "catppuccin-mocha"
  },
  lazy = false,
  after = function()
    vim.cmd.colorscheme("catppuccin-mocha")
  end
}
