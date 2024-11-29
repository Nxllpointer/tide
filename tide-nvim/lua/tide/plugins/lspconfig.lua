return {
  "lspconfig",
  ft = { "typst" },
  after = function()
    local lspconfig = require("lspconfig")

    lspconfig.tinymist.setup {
      cmd = { NIX_VALUES.tinymist_path };

      root_dir = function(filepath)
        tideproject = require("tide.tideproject").current()
        return (tideproject and tideproject.root)
      end,

      settings = {
        formatterMode = "typstyle",
      },

      capabilities = require('blink.cmp').get_lsp_capabilities({}, true),

      on_attach = function(client, buffer)
        preview = require("tide.preview")
        preview.create_autocmds(buffer)
        require("which-key").add(require("tide.mappings").preview(buffer))
      end
    }
  end
}
