{
  pkgs,
  plugins,
}: rec {
  startPlugins = {
    tide = ./../tide-nvim;
    lze = plugins.lze;
  };

  optPlugins = {
    treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins treeSitterGrammars;
    blink-cmp = (pkgs.fetchNpinsFlake plugins.blink-cmp).packages.${pkgs.system}.blink-cmp;
    inherit (plugins) auto-save autopairs catppuccin devicons gitsigns lspconfig lualine markview neo-tree telescope which-key nui plenary;
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
