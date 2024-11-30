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
      tide = pkgs.runCommand "tide" {} ''
        mkdir -p $out/bin
        ln -s ${tide-wrapped}/bin/nvim $out/bin/tide
      '';
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

    neovim-src = {
      url = "github:Nxllpointer/neovim/rtp-no-xdg-0.10";
      flake = false;
    };

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

    lualine = {
      url = "github:nvim-lualine/lualine.nvim";
      flake = false;
    };

    markview = {
      url = "github:OXY2DEV/markview.nvim";
      flake = false;
    };

    telescope = {
      url = "github:nvim-telescope/telescope.nvim?ref=0.1.x";
      flake = false;
    };

    autopairs = {
      url = "github:windwp/nvim-autopairs";
      flake = false;
    };

    gitsigns = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
  };
}
