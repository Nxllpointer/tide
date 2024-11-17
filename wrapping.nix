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

  initLua =
    # lua
    ''
      NIX_VALUES = {
        tinymist_path = "${pkgs.tinymist-rnote}/bin/tinymist";
      };
    '';
}
