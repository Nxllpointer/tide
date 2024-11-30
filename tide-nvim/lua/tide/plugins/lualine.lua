return {
  "lualine",
  event = "DeferredUIEnter",
  after = function()
    require('lualine').setup {
      options = {
        globalstatus = true
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "b:gitsigns_status_dict.head", "b:gitsigns_status" },
        lualine_c = {},
        lualine_x = { "searchcount", "selectioncount" },
        lualine_y = { { "tabs", show_modified_status = false } },
        lualine_z = { require("tide.tideproject").status_item() }
      },
      winbar = {
        lualine_a = { { 'filename', path = 1 } },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "location", "progress", "diagnostics" },
        lualine_z = { "filetype" }
      },
      inactive_winbar = {
        lualine_a = { { "filename", path = 1 } },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      extensions = {
        {
          filetypes = { "neo-tree" },
          winbar = {
            lualine_a = { '"Neotree"' },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
          }
        }
      }
    }
  end
}
