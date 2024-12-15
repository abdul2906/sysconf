{ config, ... }:

{
  users.users.hu = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = "/nix/config/secrets/pass";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.hu = {
      home.username = "hu";
      home.homeDirectory = "/home/hu";
      home.stateVersion = config.system.stateVersion;
    };
  };

  imports = [
    ./persist.nix
  ];
}

