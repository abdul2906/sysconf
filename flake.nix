{
  description = "Modular NixOS configuration.";

  inputs = {
    impermanence.url = "github:nix-community/impermanence";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, impermanence, home-manager, ... }:
    {
      nixosConfigurations.workstation = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
	  impermanence.nixosModules.impermanence
	  home-manager.nixosModules.home-manager
	  ./machines/workstation.nix
	  ./users/hu/user.nix
	];
      };
    };
}
