{
  description = "Typst notetaking IDE";

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

      tide-wrapped = mnw.lib.wrap pkgs (import ./wrapping.nix inputs pkgs);
      tide = pkgs.writeShellScriptBin "tide" "${tide-wrapped}/bin/nvim $@";
    in {
      packages = {
        inherit tide;
        config-dir = tide-wrapped.builtConfigDir;
        default = tide;
      };

      formatter = pkgs.alejandra;
    });

  inputs = {
    systems.url = "github:nix-systems/default-linux";

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    mnw.url = "github:Gerg-L/mnw";

    tinymist-rnote.url = "github:Nxllpointer/tinymist?ref=rnote";

    lze = {
      url = "github:BirdeeHub/lze";
      flake = false;
    };

    catppuccin = {
      url = "github:catppuccin/nvim";
      flake = false;
    };

    nvim-lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };

    blink-cmp.url = "github:Saghen/blink.cmp";
    
    nvim-web-devicons = {
      url = "github:nvim-tree/nvim-web-devicons";
      flake = false;
    };

    which-key = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };
    
    plenary = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };

    nui = {
      url = "github:MunifTanjim/nui.nvim";
      flake = false;
    };

    neo-tree = {
      url = "github:nvim-neo-tree/neo-tree.nvim";
      flake = false;
    };
  };
}
