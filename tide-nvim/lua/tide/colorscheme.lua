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
    require("catppuccin").setup({
      default_integrations = false,
      integrations = {
        blink_cmp = true,
        neotree = true
      },
    })

    vim.cmd.colorscheme("catppuccin-mocha")
  end
}
