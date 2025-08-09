{
  description = "Typst notetaking IDE";

  inputs = {
    systems.url = "github:nix-systems/default-linux";

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    mnw.url = "github:Gerg-L/mnw";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    mnw,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [(import ./overlay.nix inputs)];
      };

      npins-plugins = pkgs.wrapNpins "npins-plugins" "./wrapping/plugins";

      tide-wrapped = import ./wrapping {inherit pkgs mnw;};
      tide = pkgs.runCommand "tide" {} ''
        mkdir -p $out/bin
        ln -s ${tide-wrapped}/bin/nvim $out/bin/tide
      '';
    in {
      devShells.default = pkgs.mkShell {
        packages = [npins-plugins];
      };

      packages = {
        inherit tide;
        config-dir = tide-wrapped.builtConfigDir;
        default = tide;
      };

      formatter = pkgs.alejandra;
    });
}
