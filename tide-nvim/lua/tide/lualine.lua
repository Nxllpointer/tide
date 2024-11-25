lze.load {
  "lualine",
  event = "DeferredUIEnter",
  after = function()
    require('lualine').setup {
      options = {
        globalstatus = true
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = {},
        lualine_x = { "searchcount", "selectioncount" },
        lualine_y = { 'require("tide.tideproject").status_item()' },
        lualine_z = { "mode" }
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
        lualine_a = { { "filename", path = 1 }},
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
