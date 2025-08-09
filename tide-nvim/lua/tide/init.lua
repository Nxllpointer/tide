local lze = require("lze")

require("tide.opts")
require("tide.lsp")
require("tide.rnote")
require("tide.auto-checktime")

lze.load {
  { import = "tide.plugins.dependencies" },
  { import = "tide.plugins.autopairs" },
  { import = "tide.plugins.auto-save" },
  { import = "tide.plugins.blink-cmp" },
  { import = "tide.plugins.catppuccin" },
  { import = "tide.plugins.devicons" },
  { import = "tide.plugins.gitsigns" },
  { import = "tide.plugins.lspconfig" },
  { import = "tide.plugins.lualine" },
  { import = "tide.plugins.markview" },
  { import = "tide.plugins.neo-tree" },
  { import = "tide.plugins.telescope" },
  { import = "tide.plugins.treesitter" },
  { import = "tide.plugins.which-key" },
}
