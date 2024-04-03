{
  description = "Modular NixOS configuration.";

  inputs = {
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { self, nixpkgs, impermanence, ... }:
    {
      nixosConfigurations.workstation = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
	  impermanence.nixosModules.impermanence
	  ./machines/workstation.nix
	  ./users/hu.nix
	];
      };
    };
}
