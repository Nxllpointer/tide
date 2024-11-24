local M = {}

local CONFIG_NAME = "tideproject.json"

function M.root_detector(filepath, buffer)
  return vim.fs.root(filepath, { CONFIG_NAME })
end

function load_config(root_dir)
  local config_file = io.open(vim.fs.joinpath(root_dir, CONFIG_NAME))
  local config_content = config_file:read("*all")
  local config = vim.json.decode(config_content)
  config_file:close()

  local typst_template_dir = config.typst_template_dir
  local rnote_template_file = config.rnote_template_file

  vim.validate {
    typst_template_dir = { typst_template_dir, "string" },
    rnote_template_file = { rnote_template_file, "string" }
  }

  typst_template_dir = vim.fs.joinpath(root_dir, typst_template_dir)
  rnote_template_file = vim.fs.joinpath(root_dir, rnote_template_file)

  if vim.fn.isdirectory(typst_template_dir) == 0 then
    error("Invalid typst template directory: " .. typst_template_dir)
  end
  if vim.fn.filereadable(rnote_template_file) == 0 then
    error("Invalid rnote template file: " .. rnote_template_file)
  end
  
  return {
    typst_template_dir = typst_template_dir,
    rnote_template_file = rnote_template_file
  }
end

local function insert_line(buffer, cursor, text)
  local line_start, line_end = cursor[1] - 1, cursor[1] - 1 -- Cursor is 1-indexed, functions require 0-indexed

  local current_text = vim.api.nvim_buf_get_lines(buffer, line_start, line_end + 1, true)[1]
  if current_text:match("^%s*$") then -- If only whitespace
    line_end = line_end + 1 -- +1 means replace current line
  else
    line_start, line_end = line_start + 1, line_end + 1 -- Insert below current line
  end

  vim.api.nvim_buf_set_lines(buffer, line_start, line_end, true, { text })
end

function M.open(root_dir)
  local config_status, config_result = pcall(load_config, root_dir)

  if config_status == false then
    vim.notify("Unable to load " .. CONFIG_NAME .. " -> " .. config_result, vim.log.levels.WARN)
    return nil
  end

  local P = {
    root = root_dir,
    config = config_result
  }

  function P:new_rnote_doc()
    local plenary = require("plenary")
    local window = vim.api.nvim_get_current_win()
    local buffer = vim.api.nvim_win_get_buf(window)
    local cursor = vim.api.nvim_win_get_cursor(window)

    vim.ui.input(
      { prompt = "Name of Rote document: " },
      function(name)
        if name == nil or name == "" then
          vim.notify("Aborted creation of Rnote document")
          return
        end
        
        local base_name = name .. ".rnote"
        local directory = plenary.path:new(vim.fs.dirname(vim.api.nvim_buf_get_name(buffer)))
        local filepath = directory:joinpath(base_name)

        if filepath:exists() then
          vim.notify("File exists already", vim.log.levels.WARN)
          return
        end

        local template_path = plenary.path:new(self.config.rnote_template_file)
        template_path:copy({ destination = filepath })
        
        insert_line(buffer, cursor, [[#image("]] .. base_name .. [[")]])

        require("tide.rnote").open(tostring(filepath))
        require("neo-tree.sources.manager").refresh("filesystem")
      end
    )
  end

  return P
end

function M.current()
  return M.open(vim.fn.getcwd())
end

return M
