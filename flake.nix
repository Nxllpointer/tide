{
  description = "Typst notetaking IDE";

  inputs = {
    systems.url = "github:nix-systems/default-linux";

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [(import ./overlay.nix inputs)];
      };

      npins-plugins = pkgs.wrapNpins "npins-plugins" "./wrapping/plugins";
      tide = pkgs.callPackage ./wrapping {};
    in {
      devShells.default = pkgs.mkShell {
        packages = [npins-plugins];
      };

      packages = {
        inherit tide;
        config-dir = tide.configDir;
        default = tide;
      };

      formatter = pkgs.alejandra;
    });
}
