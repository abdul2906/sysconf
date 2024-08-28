{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";
    impermanence.url = "github:nix-community/impermanence";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { 
    nixpkgs,
    impermanence,
    home-manager,
    nur,
    plasma-manager,
    ...
  } @ inputs: let
    lib = nixpkgs.lib.extend (final: prev: 
      import ./lib { lib = final; }
    );
  in {
    nixosConfigurations = lib.mkHosts {
      modules = [
        home-manager.nixosModules.home-manager {
          home-manager.sharedModules = [ 
            nur.hmModules.nur
            plasma-manager.homeManagerModules.plasma-manager
          ];
        }

        impermanence.nixosModules.impermanence
        nur.nixosModules.nur
      ];
      nixpkgs = nixpkgs;
      inputs = inputs;
    };
  };
}

