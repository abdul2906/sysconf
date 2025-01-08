{
  description = "My NixOS configuration files.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { 
    nixpkgs,
    nixpkgs-unstable,
    flake-parts,
    impermanence,
    home-manager,
    disko,
    ...
  } @ inputs: let
    lib = nixpkgs.lib.extend (final: prev: 
      import ./lib { lib = final; }
    );
  in {
    nixosConfigurations = lib.mkHosts {
      nixpkgs = nixpkgs;
      inputs = inputs;
      modules = [
        disko.nixosModules.disko
      ];
    };
  };
}

