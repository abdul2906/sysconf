{
  description = "My NixOS configuration files.";

  inputs = {
    secrets.url = "git+ssh://git@git.caem.dev/caem/secrets.git";

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

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpak = {
      url = "github:nixpak/nixpak";
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
    sops-nix,
    secrets,
    nixpak,
    ...
  } @ inputs: let
    lib = nixpkgs.lib.extend (final: prev:
      import ./lib { lib = final; }
    );
  in {
    nixosConfigurations = lib.mkHosts {
      nixpkgs = nixpkgs;
      inputs = inputs;
      user = "caem";
      modules = [
        impermanence.nixosModules.impermanence
        disko.nixosModules.disko
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit inputs;
            };
          };
        }
      ];
    };
  };
}

