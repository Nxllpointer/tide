inputs: final: prev: {
  tinymist-rnote = inputs.tinymist-rnote.packages.${final.system}.tinymist;

  npins = import inputs.npins {pkgs = final;};

  wrapNpins = name: lockdir:
    final.stdenv.mkDerivation {
      inherit name;
      src = final.npins;
      nativeBuildInputs = [prev.makeWrapper];
      installPhase = "makeWrapper $src/bin/npins $out/bin/${name} --add-flags -d=${lockdir}";
    };

  fetchNpinsFlake = pin: builtins.getFlake "github:${pin.repository.owner}/${pin.repository.repo}/${pin.revision}";

  code-lldb = final.stdenv.mkDerivation {
    src = final.vscode-extensions.vadimcn.vscode-lldb;
    installPhase = ''
      mkdir -p $out/bin
      ln -s $src
    '';
  };
}
