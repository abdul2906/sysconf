{ lib, config, ... }:

{
  imports = [
    ./packages.nix
  ];

  home = {
    username = "caem";
    homeDirectory = "/home/caem";
    stateVersion = "24.11";
  };

  home.file."${config.xdg.configHome}/user-dirs.dirs".force = lib.mkForce true;
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/download";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/images";
      videos = "${config.home.homeDirectory}/videos";

      /* I do not use these */
      desktop = "${config.xdg.dataHome}/xdg/desktop";
      publicShare = "${config.xdg.dataHome}/xdg/publicShare";
      templates = "${config.xdg.dataHome}/xdg/templates";
    };
  };
}
