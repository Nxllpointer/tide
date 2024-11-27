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
        neotree = true,
        which_key = true,
        native_lsp = { -- Having to specify all values is considered a bug https://github.com/catppuccin/nvim/issues/763
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "underline" },
          },
          inlay_hints = {
            background = false,
          }
        }
      },
    })

    vim.cmd.colorscheme("catppuccin-mocha")
  end
}
