{ pkgs, lib, inputs, cfgPath, ... }:

let
  importOverlays = builtins.map
    (overlay: import overlay { inherit lib inputs pkgs cfgPath; })
    (builtins.filter 
      (file: builtins.match ".*\.nix" (builtins.toString file) != null)
      (lib.filesystem.listFilesRecursive "${cfgPath}/overlays"));
in {
  nix = {
    settings = {
      auto-optimise-store = true;
      use-xdg-base-directories = true;
      trusted-users = [ "@wheel" ];
      allowed-users = [ "@wheel" ];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    hostPlatform = lib.mkDefault "x86_64-linux";
    overlays = importOverlays;
  };
}
