{
  pkgs,
  plugins,
}: rec {
  startPlugins = {
    tide = ./../tide-nvim;
    lze = plugins.lze;
  };

  optPlugins = {
    nvim-treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins treeSitterGrammars;
    blink-cmp = (pkgs.fetchNpinsFlake plugins.blink-cmp).packages.${pkgs.system}.blink-cmp;
    catppuccin = plugins.catppuccin;
    lspconfig = plugins.nvim-lspconfig;
    nvim-web-devicons = plugins.nvim-web-devicons;
    which-key = plugins.which-key;
    plenary = plugins.plenary;
    nui = plugins.nui;
    neo-tree = plugins.neo-tree;
    lualine = plugins.lualine;
    markview = plugins.markview;
    telescope = plugins.telescope;
    nvim-autopairs = plugins.autopairs;
    gitsigns = plugins.gitsigns;
    auto-save = plugins.autosave;
  };

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
