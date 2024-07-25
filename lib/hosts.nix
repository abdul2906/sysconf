{ lib }:

{
  mkHosts = {
    modules,
    nixpkgs,
    inputs,
  }: builtins.listToAttrs (builtins.map (host: {
      name = host;
      value = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = modules ++ [ ../hosts/${host} ];
        specialArgs = { inherit inputs; };
      };
    }) (lib.getDirsInDir ../hosts));
}
