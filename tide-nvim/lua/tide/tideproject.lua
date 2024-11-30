local Path = require("plenary").path

local M = {}

local CONFIG_NAME = "tideproject.json"

function M.root_detector(filepath)
  return vim.fs.root(filepath, { CONFIG_NAME })
end

local function load_config(root_dir)
  root_dir = Path:new(root_dir)
  local config_file = io.open(tostring(root_dir:joinpath(CONFIG_NAME):absolute()))
  local config_content = config_file:read("*all")
  local config = vim.json.decode(config_content)
  config_file:close()

  local typst_template_dir = config.typst_template_dir
  local rnote_template_file = config.rnote_template_file
  local resources_subdir = config.resources_subdir or "resources"

  vim.validate {
    typst_template_dir = { typst_template_dir, "string" },
    rnote_template_file = { rnote_template_file, "string" },
    resources_subdir = { resources_subdir, function(val) return type(val) == "string" or val == vim.NIL end, "string or null" }
  }

  typst_template_dir = root_dir:joinpath(typst_template_dir)
  rnote_template_file = root_dir:joinpath(rnote_template_file)

  if typst_template_dir:is_dir() == 0 then
    error("Invalid typst template directory: " .. typst_template_dir)
  end
  if rnote_template_file:is_file() == 0 then
    error("Invalid rnote template file: " .. rnote_template_file)
  end

  return {
    typst_template_dir = tostring(typst_template_dir),
    rnote_template_file = tostring(rnote_template_file),
    resources_subdir = resources_subdir
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

        local relative_file_path = Path:new(name .. ".rnote")
        if self.config.resources_subdir ~= vim.NIL then
          relative_file_path = Path:new(self.config.resources_subdir):joinpath(relative_file_path)
        end

        local note_directory = Path:new(vim.fs.dirname(vim.api.nvim_buf_get_name(buffer)))
        if not note_directory:exists() then
          vim.notify("Unable to find note directory", vim.log.levels.WARN)
          return
        end

        local filepath = note_directory:joinpath(relative_file_path)
        filepath:parent():mkdir()

        if filepath:exists() then
          vim.notify("File exists already", vim.log.levels.WARN)
          return
        end

        local template_path = Path:new(self.config.rnote_template_file)
        template_path:copy({ destination = filepath })

        insert_line(buffer, cursor, [[#image("]] .. relative_file_path .. [[")]])

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

function M.status_item()
  local function load_config_safe()
    local root = Path:new(vim.fn.getcwd())
    if root:joinpath(CONFIG_NAME):is_file() ~= 0 then
      local status, result = pcall(load_config, root)
      return status, result
    else
      return nil, nil
    end
  end

  return {
    function()
      local config_status = load_config_safe()

      local msg
      if config_status ~= nil then
        if config_status == true then
          msg = "Active"
        else
          msg = "Config error (Click)"
        end
      else
        msg = "Not found"
      end

      return "Tideproject: " .. msg
    end,
    on_click = function()
      local config_status, result = load_config_safe()
      if config_status ~= nil then
        vim.notify(vim.inspect(result))
      end
    end
  }
end

return M
