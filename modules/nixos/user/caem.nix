{ config, pkgs, ... }:

{
  users.users.caem = {
    isNormalUser = true;
    shell = pkgs.zsh;
    hashedPasswordFile = config.sops.secrets.upasswd.path;
    extraGroups = [
      "wheel"
    ];
  };

  home-manager.users.caem = import ../../home/caem;
}
