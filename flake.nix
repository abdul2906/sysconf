{
  description = "Modular NixOS configuration.";

  inputs = {
    impermanence.url = "github:nix-community/impermanence";

    home-manager = {
      url = "github:nix-community/home-manager";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
    };
  };

  outputs = { self, nixpkgs, impermanence, home-manager, aagl, ... }:
    {
      nixosConfigurations.workstation = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
	  impermanence.nixosModules.impermanence
	  home-manager.nixosModules.home-manager
	  aagl.nixosModules.default
	  ./machines/workstation.nix
	  ./users/hu/user.nix
	];
      };
    };
}
