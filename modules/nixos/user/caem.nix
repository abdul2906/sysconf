{ config, pkgs, ... }:

{
  sops.secrets.user_password = {
    sopsFile = ../../../secrets/user_password.yaml;
    neededForUsers = true;
  };

  users.users.caem = {
    isNormalUser = true;
    shell = pkgs.zsh;
    hashedPasswordFile = config.sops.secrets.user_password.path;
    extraGroups = [
      "wheel"
    ];
  };

  home-manager.users.caem = import ../../home/caem;
}
