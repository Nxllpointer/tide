inputs: pkgs: let
  startPlugins = [
    {
      name = "lze";
      src = inputs.lze;
    }
    {
      name = "tide";
      src = ./tide-nvim;
    }
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (
      plugins: with plugins; [ typst ]
    ))
  ];

  optPlugins = [
    {
      name = "catppuccin";
      src = inputs.catppuccin;
    }
    {
      name = "lspconfig";
      src = inputs.nvim-lspconfig;
    }
    inputs.blink-cmp.packages.${pkgs.system}.blink-cmp
    {
      name = "nvim-web-devicons";
      src = inputs.nvim-web-devicons;
    }
    {
      name = "which-key";
      src = inputs.which-key;
    }
    {
      name = "plenary";
      src = inputs.plenary;
    }
    {
      name = "nui";
      src = inputs.nui;
    }
    {
      name = "neo-tree";
      src = inputs.neo-tree;
    }
    {
      name = "lualine";
      src = inputs.lualine;
    }
  ];

  setIsOptional = isOptional: plugins:
    map (
      plugin:
        if builtins.isAttrs plugin
        then {optional = isOptional;} // plugin
        else throw "Plugin list must only contain attribute sets but contained ${builtins.typeOf plugin}"
    )
    plugins;
in {
  appName = "tide";
  desktopEntry = false;

  withNodeJs = false;
  withPerl = false;
  withPython3 = false;
  withRuby = false;

  plugins = (setIsOptional false startPlugins) ++ (setIsOptional true optPlugins);
  
  extraBinPath = with pkgs; [ xclip wl-clipboard ];

  initLua =
    # lua
    ''
      NIX_VALUES = {
        tinymist_path = "${pkgs.tinymist-rnote}/bin/tinymist";
        rnote_path = "${pkgs.rnote}/bin/rnote";
      };
    '';
}
