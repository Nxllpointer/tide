vim.fn.timer_start(
  1000,
  function() vim.cmd.checktime() end,
  { ["repeat"] = -1 } -- Repeat forever
)
