{ lib, ... }:

{
  nix = {
    settings = {
      auto-optimise-store = true;
      use-xdg-base-directories = true;
      trusted-users = [ "@wheel" ];
      allowed-users = [ "@wheel" ];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
