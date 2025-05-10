local lze = require("lze")

require("tide.opts")
require("tide.lsp")
require("tide.rnote")
require("tide.auto-checktime")

lze.load {
  { import = "tide.plugins.dependencies" },
  { import = "tide.plugins.autopairs" },
  { import = "tide.plugins.autosave" },
  { import = "tide.plugins.blink" },
  { import = "tide.plugins.catppuccin" },
  { import = "tide.plugins.debugmaster" },
  { import = "tide.plugins.devicons" },
  { import = "tide.plugins.fidget" },
  { import = "tide.plugins.gitsigns" },
  { import = "tide.plugins.lazydev" },
  { import = "tide.plugins.lspconfig" },
  { import = "tide.plugins.lualine" },
  { import = "tide.plugins.markview" },
  { import = "tide.plugins.neotree" },
  { import = "tide.plugins.nvim-dap" },
  { import = "tide.plugins.r-nvim" },
  { import = "tide.plugins.telescope" },
  { import = "tide.plugins.treesitter" },
  { import = "tide.plugins.which-key" },
}
