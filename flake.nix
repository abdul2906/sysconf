{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";
    impermanence.url = "github:nix-community/impermanence";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    ags.url = "github:Aylur/ags";
  };

  outputs = { nixpkgs, impermanence, home-manager, aagl, nur, stylix, ags, ... }:
    {
      nixosConfigurations.workstation = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager {
            home-manager.sharedModules = [ 
              nur.hmModules.nur
              ags.homeManagerModules.default
            ];
          }
          impermanence.nixosModules.impermanence
          nur.nixosModules.nur
          stylix.nixosModules.stylix
          aagl.nixosModules.default

          ./machines/workstation/configuration.nix
        ];
      };
    };
}

