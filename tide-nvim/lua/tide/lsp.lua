vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_hover] = function(err, result, ctx)
  local buffer, window = vim.lsp.handlers.hover(err, result, ctx, {
    wrap = false
  })

  if buffer and window then
    vim.api.nvim_win_set_width(window, vim.api.nvim_win_get_width(window) + 2) -- Add space for signcolumn
  end
end
