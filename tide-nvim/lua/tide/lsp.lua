local BORDER = "rounded"

local function get_required_window_width(window)
  local actual_height = vim.api.nvim_win_text_height(window, {}).all
  local actual_width = 0

  for linenr = 1, actual_height do
    actual_width = math.max(
      actual_width,
      vim.fn.virtcol({ linenr, "$" }, 0, window)
    )
  end

  return actual_width
end

vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_hover] = function(err, result, ctx)
  local buffer, window = vim.lsp.handlers.hover(err, result, ctx, {
    wrap = false,
    border = BORDER
  })

  if buffer and window then
    vim.api.nvim_win_set_width(window, get_required_window_width(window))
  end
end

vim.diagnostic.config {
  float = {
    border = BORDER
  }
}

vim.lsp.inlay_hint.enable(true)
