{
  pkgs,
  plugins,
}: rec {
  startPlugins = [
    {
      name = "lze";
      src = plugins.lze;
    }
    {
      name = "tide";
      src = ./../tide-nvim;
    }
  ];
  optPlugins = [
    (pkgs.vimPlugins.nvim-treesitter.withPlugins treeSitterGrammars)
    (pkgs.fetchNpinsFlake plugins.blink-cmp).packages.${pkgs.system}.blink-cmp
    {
      name = "catppuccin";
      src = plugins.catppuccin;
    }
    {
      name = "lspconfig";
      src = plugins.nvim-lspconfig;
    }
    {
      name = "nvim-web-devicons";
      src = plugins.nvim-web-devicons;
    }
    {
      name = "which-key";
      src = plugins.which-key;
    }
    {
      name = "plenary";
      src = plugins.plenary;
    }
    {
      name = "nui";
      src = plugins.nui;
    }
    {
      name = "neo-tree";
      src = plugins.neo-tree;
    }
    {
      name = "lualine";
      src = plugins.lualine;
    }
    {
      name = "markview";
      src = plugins.markview;
    }
    {
      name = "telescope";
      src = plugins.telescope;
    }
    {
      name = "nvim-autopairs";
      src = plugins.autopairs;
    }
    {
      name = "gitsigns";
      src = plugins.gitsigns;
    }
    {
      name = "auto-save";
      src = plugins.autosave;
    }
  ];

  treeSitterGrammars = grammars:
    with grammars; [
      typst
      markdown
      markdown_inline
      html
    ];

  extraPackages = with pkgs; [
    typst
    tinymist
    xclip
    wl-clipboard
    ripgrep
  ];
}
