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

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, impermanence, home-manager, aagl, nur, ... } @ inputs:
    {
      nixosConfigurations.workstation = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; } ;
        modules = [
          home-manager.nixosModules.home-manager {
            home-manager.sharedModules = [ 
              nur.hmModules.nur
            ];
          }
          impermanence.nixosModules.impermanence
          nur.nixosModules.nur
          aagl.nixosModules.default

          ./machines/workstation/configuration.nix
        ];
      };
    };
}

