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
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };
  };

  outputs = { nixpkgs, impermanence, home-manager, aagl, nur, ... } @ inputs:
    let
      lib = nixpkgs.lib.extend (final: prev: 
        import ./lib { lib = final; }
      );
    in
    {
      nixosConfigurations = lib.mkHosts {
        modules = [
          home-manager.nixosModules.home-manager {
            home-manager.sharedModules = [ 
              nur.hmModules.nur
            ];
          }
          impermanence.nixosModules.impermanence
          nur.nixosModules.nur
          aagl.nixosModules.default
        ];
        nixpkgs = nixpkgs;
        inputs = inputs;
      };
    };
}

