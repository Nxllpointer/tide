{
  pkgs,
  mnw,
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

    plugins = (setIsOptional false options.startPlugins) ++ (setIsOptional true options.optPlugins);

    extraBinPath = options.extraPackages;
  }
