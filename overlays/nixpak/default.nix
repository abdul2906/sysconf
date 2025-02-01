{ inputs, lib, ... }: final: prev: {
  mkNixPak = let
    pkgs = prev;
  in inputs.nixpak.lib.nixpak {
    inherit (pkgs) lib;
    inherit pkgs;
  };
}
