inputs: final: prev: {
  wrapNpins = name: lockdir:
    prev.stdenv.mkDerivation {
      inherit name;
      src = final.npins;
      nativeBuildInputs = [prev.makeWrapper];
      installPhase = "makeWrapper $src/bin/npins $out/bin/${name} --add-flags -d=${lockdir}";
    };

  fetchNpinsFlake = pin: builtins.getFlake "github:${pin.repository.owner}/${pin.repository.repo}/${pin.revision}";
}
