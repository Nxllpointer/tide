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

  return P
end

function M.current()
  return M.open(vim.fn.getcwd())
end

return M
