{
  pkgs,
  mnw,
  neovim-src,
}: let
  setIsOptional = isOptional: plugins:
    map (
      plugin:
        if builtins.isAttrs plugin
        then {optional = isOptional;} // plugin
        else throw "Plugin list must only contain attribute sets but contained ${builtins.typeOf plugin}"
    )
    plugins;

  options = import ./options.nix {
    inherit pkgs;
    plugins = import ./plugins;
  };
in
  mnw.lib.wrap pkgs {
    appName = "tide";
    desktopEntry = false;

    withNodeJs = false;
    withPerl = false;
    withPython3 = false;
    withRuby = false;

    neovim = pkgs.neovim-unwrapped.overrideAttrs {src = neovim-src;};

    plugins = (setIsOptional false options.startPlugins) ++ (setIsOptional true options.optPlugins);

    extraBinPath = options.extraPackages;

    initLua =
      # lua
      ''
        NIX_VALUES = {
          tinymist_path = "${pkgs.tinymist-rnote}/bin/tinymist";
          rnote_path = "${pkgs.rnote}/bin/rnote";
        };
      '';
  }
