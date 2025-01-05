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

      xdg = {
        enable = true;
        userDirs = {
          documents = "/home/hu/documents";
          download = "/home/hu/download";
          music = "/home/hu/music";
          pictures = "/home/hu/images";
          videos = "/home/hu/videos";

          # I will never need this so they're getting hidden
          publicShare = "/home/hu/.local/share/xdg/public";
          templates = "/home/hu/.local/share/xdg/templates";
        };
      };
    };
  };

  imports = [
    ./persist.nix
  ];
}

