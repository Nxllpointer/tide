local BORDER = "rounded"

vim.diagnostic.config {
  float = {
    border = BORDER
  }
}

vim.lsp.inlay_hint.enable(true)
