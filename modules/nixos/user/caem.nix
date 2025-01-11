{ pkgs, ... }:

{
  users.users.caem = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
    ];
  };

  home-manager.users.caem = import ../../home/caem;
}
