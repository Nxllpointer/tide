return {
  "neo-tree",
  cmd = "Neotree",
  on_require = "neo-tree",
  after = function()
    local log = require("neo-tree.log")
    local utils = require("neo-tree.utils")
    local fs = require("neo-tree.sources.filesystem")
    local fs_actions = require("neo-tree.sources.filesystem.lib.fs_actions")

    require("neo-tree").setup {
      filesystem = {
        window = {
          mappings = require("tide.mappings").neotree()
        },
        commands = {
          new_typst_note = function(state)
            local node = state.tree:get_node()

            local base_directory = nil
            if node:is_expanded() then
              base_directory = node:get_id()
            else
              base_directory = node:get_parent_id()
            end

            if base_directory == nil then
              log.error("No base directory for selected item found")
              return
            end

            local tideproject = require("tide.tideproject").current()
            if tideproject == nil then
              return
            end

            fs_actions.copy_node(
              tideproject.config.typst_template_dir,
              base_directory,
              utils.wrap(fs.focus_destination_children, state),
              base_directory
            )
          end
        }
      }
    }
  end
}
