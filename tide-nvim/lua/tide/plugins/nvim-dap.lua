return {
  "nvim-dap",
  on_require = "dap",
  after = function()
    local dap = require("dap")
    dap.adapters.lldb = {
      type = "executable",
      command = "lldb-dap"
    }

    dap.configurations.rust = {
      {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
      }
    }

    vim.fn.sign_define(
      "DapBreakpoint",
      { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" }
    )
    vim.fn.sign_define(
      "DapBreakpointCondition",
      { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
    )
    vim.fn.sign_define(
      "DapLogPoint",
      { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" }
    )
  end
}
