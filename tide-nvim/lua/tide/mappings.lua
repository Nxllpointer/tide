vim.g.mapleader = " "

local M = {}

-- General keybinds
function M.other()
  return {
    { "<leader><tab>", vim.cmd.Neotree, desc = "Open File Tree" },
    { "<leader><leader>", function() vim.cmd.Telescope("find_files") end, desc = "Open File Finder" },
    { "<leader>b", function() vim.cmd.Telescope("buffers") end, desc = "List Buffers" },
    { "<leader>g", function() vim.cmd.Telescope("live_grep") end, desc = "Grep Working Directory" },
    { "<leader>r", function() vim.cmd.Telescope("resume") end, desc = "Resume Telescope" },

    { "<leader>c", group = "Code" },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "Action" },
    { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
    { "<leader>cf", vim.lsp.buf.format, desc = "Format" },
    { "<leader>cd", function() vim.cmd.Telescope("lsp_definitions") end, desc = "Definitions" },
    { "<leader>cu", function() vim.cmd.Telescope("lsp_references") end, desc = "Usages" },
    { "<leader>cs", function() vim.cmd.Telescope("lsp_document_symbols") end, desc = "Symbols" },

    { "<C-Space>", vim.cmd.stopinsert, desc = "Exit terminal mode", mode = "t" }
  }
end

-- File tree keybinds
-- Press ? to show the help window
function M.neotree()
  return {
    ["<space>"] = "none", -- Fix for using space as <leader>
    ["n"] = "new_typst_note" -- Copy the typst template to the specified location in the current context
  }
end

-- Keybinds when a preview server is attached
function M.preview(buffer)
  local preview = require("tide.preview")
  return {
    mode = "n",
    buffer = buffer,
    { "<leader>p", preview.start, desc = "Preview > Start" },
    { "<leader>P", preview.kill, desc = "Preview > Stop" },
    { "<leader>m", preview.pin, desc = "Preview > Pin Main File" },
    { "<leader>M", preview.unpin, desc = "Preview > Unpin Main File" },
  }
end

-- Keybinds for typst files
function M.typst(buffer)
  return {
    mode = "n",
    buffer = buffer,
    {
      "<leader>n",
      function()
        local tideproject = require("tide.tideproject").current()
        if tideproject ~= nil then
          tideproject:new_rnote_doc()
        end
      end,
      desc = "New Rnote Document"
    }
  }
end

-- Keybinds for autocompletion
-- Multiple actions are cycled when pressing the keybind multiple times
function M.blink()
  return {
    preset = "enter", -- See https://github.com/Saghen/blink.cmp/blob/4cc0e2bc27fc5ff67f846808e42d3046e05c2f11/lua/blink/cmp/keymap.lua#L47
    ['<C-space>'] = {
      'show',
      require("blink.cmp.trigger.signature").show,
      'show_documentation', 'hide_documentation'
    },
    ['<C-e>'] = {
      vim.schedule_wrap(require("blink.cmp.trigger.signature").hide),
      'hide'
    },
  }
end

return M
