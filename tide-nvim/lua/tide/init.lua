local lze = require("lze")
lze.register_handlers(require('lze.x.on_require'))

require("tide.opts")
require("tide.lsp")
require("tide.rnote")

lze.load {
  { import = "tide.plugins.dependencies" },
  { import = "tide.plugins.autopairs" },
  { import = "tide.plugins.autosave" },
  { import = "tide.plugins.blink" },
  { import = "tide.plugins.catppuccin" },
  { import = "tide.plugins.devicons" },
  { import = "tide.plugins.gitsigns" },
  { import = "tide.plugins.lazydev" },
  { import = "tide.plugins.lspconfig" },
  { import = "tide.plugins.lualine" },
  { import = "tide.plugins.markview" },
  { import = "tide.plugins.neotree" },
  { import = "tide.plugins.r-nvim" },
  { import = "tide.plugins.telescope" },
  { import = "tide.plugins.treesitter" },
  { import = "tide.plugins.which-key" },
}
