{ config, lib, pkgs, ... }:

{
  programs.zsh.enable = true;
  environment.variables = {
    ZDOTDIR = "${config.users.users.hu.home}/.config/zsh";
  };

  users.users.hu = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    hashedPasswordFile = "/nix/config/secrets/hu/pass";
  };

  # Todo: home-manager configuration
}
