lze.load {
  "lspconfig",
  ft = {"typst"},
  after = function()
    local lspconfig = require("lspconfig")

    lspconfig.tinymist.setup {
      cmd = { NIX_VALUES.tinymist_path };
      settings = {
        formatterMode = "typstyle",
      }
    }
  end
}
