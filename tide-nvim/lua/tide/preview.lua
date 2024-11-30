local M = {}

local TASK_ID = "tide-preview"
local FIREFOX_PROFILE = "tide-preview"

local function tinymist()
  local clients = vim.lsp.get_clients {
    name = "tinymist",
    bufnr = 0
  }

  if #clients ~= 0 then
    return clients[1]
  else
    return nil
  end
end

local function execute_command(command, arguments, handler)
  local client = tinymist()
  if client == nil then
    vim.notify("No tinymist instance for command found", vim.log.levels.ERROR)
    return
  end

  client.request(
    vim.lsp.protocol.Methods.workspace_executeCommand,
    {
      command = command,
      arguments = arguments
    },
    handler
  )
end

function M.kill(disable_output)
  local handler = nil
  if disable_output then
    handler = function() end
  end

  execute_command(
    "tinymist.doKillPreview",
    { TASK_ID },
    handler
  )
end

function M.start(file)
  file = file or vim.api.nvim_buf_get_name(0)

  M.kill(true)

  execute_command(
    "tinymist.doStartPreview",
    {{
      "--task-id", TASK_ID,
      "--refresh-style", "onType",
      "--data-plane-host", "127.0.0.1:0",
      "--control-plane-host", "127.0.0.1:0",
      file
    }},
    function(err, response, ctx)
      if err ~= nil then
        vim.notify("Unable to start preview:")
        vim.print(err)
      else
        vim.system {
          "firefox",
          "-P", FIREFOX_PROFILE,
          "--new-tab", response.staticServerAddr
        }
      end
    end
  )

  M.unpin()
  M.focus()
end

function M.pin(file)
  file = file or vim.api.nvim_buf_get_name(0)

  execute_command(
    "tinymist.pinMain",
    { file }
  )
end

function M.unpin()
  execute_command(
    "tinymist.pinMain",
    { nil, "" }
  )
end

function M.focus(file)
  file = file or vim.api.nvim_buf_get_name(0)

  execute_command(
    "tinymist.focusMain",
    { file }
  )
end

function M.jump()
  local file = vim.api.nvim_buf_get_name(0)
  local cursor = vim.api.nvim_win_get_cursor(0)

  execute_command(
    "tinymist.scrollPreview",
    {
      TASK_ID,
      {
        event = "panelScrollTo",
        filepath = file,
        line = cursor[1] - 1, -- Nvim lineumbers start at 1, tinymist linenumbers start at 0. This took me 2 days to figure out...
        character = cursor[2] + 1 -- Goto char under normal mode cursor, not left to it
      }
    }
  )
end

function M.create_autocmds(buf)
  vim.api.nvim_create_autocmd("BufEnter", {
    buffer = buf,
    callback = function(event)
      M.focus(event.file)
    end
  })
  vim.api.nvim_create_autocmd("CursorMoved", {
    buffer = buf,
    callback = function()
      M.jump()
    end
  })
end


return M
