{
  pkgs,
  lib,
  runCommand,
  neovim-unwrapped,
  makeBinaryWrapper,
}: let
  options = import ./options.nix {
    inherit pkgs;
    plugins = import ./plugins;
  };

  nvim = neovim-unwrapped;

  linkPlugins = variant: plugins:
    toString (builtins.attrValues (builtins.mapAttrs (name: src: ''
        ln -s ${src} $out/pack/tide-pack/${variant}/${name};
        if [ -e ${src}/doc/ ]; then ln -s ${src}/doc/ $out/doc/${name}; fi;
      '')
      plugins));

  linkTreesitterParsers = parsers:
    toString (map (p: ''
        ln -s ${p}/parser/* $out/parser/;
      '')
      parsers);

  configDir =
    runCommand "tide-config-dir" {
      nativeBuildInputs = [nvim];
    } ''
      mkdir -p $out/pack/tide-pack/{start,opt} $out/doc $out/parser
      ${linkPlugins "opt" options.optPlugins}
      ${linkPlugins "start" options.startPlugins}
      ${linkTreesitterParsers options.optPlugins.treesitter.dependencies}
      nvim --headless --clean +"helptags $out/doc" +qa
    '';

  markviewQueries = lib.sources.sourceByRegex options.optPlugins.markview ["queries(/.*)?"];

  runtimepath = [
    markviewQueries # nvim and treesitter default queries must be overridden
    "${nvim}/share/nvim/runtime"
    "${nvim}/lib/nvim"
    configDir
  ];
in
  runCommand "tide" {
    nativeBuildInputs = [makeBinaryWrapper];
    passthru = {inherit configDir;};
  } ''
    mkdir -p $out/bin
    makeBinaryWrapper ${nvim}/bin/nvim $out/bin/tide \
      --append-flags --cmd --append-flag "set rtp=${builtins.concatStringsSep "," runtimepath}" \
      --append-flags --cmd --append-flag "let &pp=&rtp" \
      --suffix PATH : ${lib.makeBinPath options.extraPackages} \
      --set NVIM_APPNAME tide
  ''
