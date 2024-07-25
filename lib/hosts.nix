{ lib }:

{
  mkHosts = {
    modules,
    nixpkgs,
    inputs,
    path ? (builtins.toString ../hosts),
  }: let
    hosts = lib.getDirsInDir path;
    common = {
      system = "x86_64-linux";
      modules = modules;
    };
  in
    builtins.listToAttrs (builtins.map (host: {
      name = host;
      value = nixpkgs.lib.nixosSystem {
        system = common.system;
        modules = common.modules ++ [ ../hosts/${host} ];
        specialArgs = { inherit inputs; };
      };
    }) hosts);
}
