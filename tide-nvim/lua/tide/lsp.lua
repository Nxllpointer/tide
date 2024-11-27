local BORDER = "rounded"

vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_hover] = function(err, result, ctx)
  local buffer, window = vim.lsp.handlers.hover(err, result, ctx, {
    wrap = false,
    border = BORDER
  })

  if buffer and window then
    vim.api.nvim_win_set_width(window, vim.api.nvim_win_get_width(window) + 2) -- Add space for signcolumn
  end
end

vim.diagnostic.config {
  float = {
    border = BORDER
  }
}

vim.lsp.inlay_hint.enable(true)
