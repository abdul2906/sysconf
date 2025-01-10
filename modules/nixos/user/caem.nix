{ pkgs, ... }:

{
  users.users.caem = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
    ];
  };
}
