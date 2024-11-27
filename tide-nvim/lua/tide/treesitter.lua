require("nvim-treesitter.configs").setup {
  ensure_installed = {},
  auto_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },

  indent = {
    enable = true
  }
}
