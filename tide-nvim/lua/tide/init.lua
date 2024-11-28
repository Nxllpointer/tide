lze = require("lze")
lze.register_handlers(require('lze.x.on_require'))

require("tide.dependencies")
require("tide.which-key")
require("tide.colorscheme")
require("tide.devicons")
require("tide.treesitter")
require("tide.markview")
require("tide.lsp")
require("tide.lspconfig")
require("tide.completion")
require("tide.neotree")
require("tide.lualine")
require("tide.rnote")
require("tide.telescope")

vim.o.clipboard = "unnamedplus"
vim.o.scrolloff = 5
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "number"
vim.o.wrap = false
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.shiftwidth = 2
vim.o.softtabstop = -1 -- Follow shiftwidth
vim.o.expandtab = true
vim.o.smartindent = false
vim.o.autoindent = true
