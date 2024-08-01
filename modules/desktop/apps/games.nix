{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    prismlauncher
    protonup-qt
    xivlauncher
    osu-lazer-bin
  ];
}

