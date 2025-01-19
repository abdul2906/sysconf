{ config, pkgs, inputs, ... }:

{
  sops.secrets.upasswd = {
    neededForUsers = true;
    sopsFile = inputs.secrets.paths.upasswd;
  };

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
