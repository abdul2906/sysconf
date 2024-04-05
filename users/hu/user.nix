{ config, lib, pkgs, ... }:

{
  imports = [
    ../../packages/sets/communication.nix
    ../../packages/sets/games.nix
  ];

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

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;
  home-manager.users.hu = { pkgs, ... }: {
    home.username = "hu";
    home.homeDirectory = "/home/hu";
    home.stateVersion = config.system.stateVersion;

    imports = [
      ./packages/git.nix
      ./packages/tmux.nix
    ];
  };
}
