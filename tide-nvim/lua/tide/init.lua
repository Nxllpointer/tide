lze = require("lze")
lze.register_handlers(require('lze.x.on_require'))

require("tide.dependencies")
require("tide.which-key")
require("tide.colorscheme")
require("tide.devicons")
require("tide.treesitter")
require("tide.lspconfig")
require("tide.completion")
require("tide.neotree")
require("tide.rnote")

vim.o.scrolloff = 5
