{ config, pkgs, inputs, ... }:

{
  sops.secrets.upasswd = {
    neededForUsers = true;
    sopsFile = inputs.secrets.paths.upasswd;
  };

  environment.persistence."/nix/persist" = {
    users.caem = {
      directories = [
        "documents"
        "download"
        "music"
        "images"
        "videos"
        "programming"
      ];
    };
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
