{ lib }:

{
  mkHosts = {
    nixpkgs,
    inputs,
    modules,
    user,
  }: builtins.listToAttrs (builtins.map (host: {
      name = host;
      value = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = modules ++ [
          ../hosts/${host}
          ../modules/nixos/user/${user}.nix
        ];
        specialArgs = { 
          inherit inputs lib;
          username = user;
          cfgPath = ../.;
        };
      };
    }) (lib.getDirsInDir ../hosts));
}
