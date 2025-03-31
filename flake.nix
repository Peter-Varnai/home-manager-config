{ description = "Home Manager configuration of root";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plugin-onedark.url = "github:navarasu/onedark.nvim";
    plugin-onedark.flake = false;
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {

    homeConfigurations."nixos" = 
      inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [ 
        ./home.nix 
        ./neovim.nix
      ];
      extraSpecialArgs = { inherit inputs; };
    };
  };
}
