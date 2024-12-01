return {
  "lspconfig",
  ft = { "typst", "lua", "nix" },
  after = function()
    local lspconfig = require("lspconfig")

    local function setup(server, config)
      config = config or {}
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities or {}, true)
      server.setup(config)
    end

    setup(lspconfig.tinymist, {
      cmd = { NIX_VALUES.tinymist_path };

      root_dir = function(filepath)
        local tideproject = require("tide.tideproject").current()
        return (tideproject and tideproject.root)
      end,

      settings = {
        formatterMode = "typstyle",
      },

      capabilities = require('blink.cmp').get_lsp_capabilities({}, true),

      on_attach = function(client, buffer)
        local preview = require("tide.preview")
        preview.create_autocmds(buffer)
        require("which-key").add(require("tide.mappings").preview(buffer))
      end
    })

    setup(lspconfig.lua_ls)
    setup(lspconfig.nil_ls)
  end
}
