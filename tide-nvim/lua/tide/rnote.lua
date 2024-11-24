local M = {}

function M.open(file)
  vim.system { NIX_VALUES.rnote_path, file }
end

-- Open rnote files externally
vim.api.nvim_create_autocmd("BufNew", {
  pattern = "*.rnote",
  callback = function(args)
    vim.notify("Opening Rnote file externally")
    vim.api.nvim_buf_delete(args.buf, {})
    M.open(args.file)
  end
})

return M
