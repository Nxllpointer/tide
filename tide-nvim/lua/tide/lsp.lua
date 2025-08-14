local BORDER = "rounded"

vim.diagnostic.config {
  float = {
    border = BORDER
  },
  underline = true,
  virtual_text = true,
  virtual_lines = false,
}

vim.lsp.inlay_hint.enable(true)

local M = {}

function M.toggle_diagnostic_mode()
  local current = vim.diagnostic.config()
  vim.diagnostic.config {
    virtual_lines = current.virtual_text,
    virtual_text = not current.virtual_text
  }
end

function vim.lsp.buf.hover()
  vim.lsp.buf_request(
    0,
    vim.lsp.protocol.Methods.textDocument_hover,
    vim.lsp.util.make_position_params(0, "utf-8"),
    function(err, result)
      if err then
        vim.notify("LSP hover failed", vim.log.levels.ERROR)
        return
      end

      if not result or not result.contents then
        vim.notify("No LSP hover information", vim.log.levels.WARN)
        return
      end

      local lsp_contents = result.contents

      local is_table = type(lsp_contents) == "table";
      local contents = is_table and (lsp_contents.value and { lsp_contents.value } or lsp_contents) or { lsp_contents }
      local is_markdown = not is_table or (result.contents.language or result.contents.kind or "markdown") == "markdown"
      local filetype = is_markdown and "markdown" or "text"

      -- Fix tinymist's ```typc code blocks
      contents = vim.tbl_map(function(s) return s:gsub("(```typ)c(\n)(let)", "%1%2#%3") end, contents)

      -- Dont use builtin markdown processing
      local float_buf, float_win = vim.lsp.util.open_floating_preview(contents, "text", {
        focus_id = "lsp-hover",
        border = BORDER,
      })

      if not vim.F.npcall(vim.api.nvim_win_get_var, float_win, "hover-patched") then
        -- Make markview render buffer
        vim.bo[float_buf].buftype = "nowrite"
        vim.bo[float_buf].filetype = filetype
        -- Add space for markview virtual text
        vim.api.nvim_win_set_width(float_win, vim.api.nvim_win_get_width(float_win) + 4)

        vim.api.nvim_win_set_var(float_win, "hover-patched", true)
      end
    end)
end

return M
