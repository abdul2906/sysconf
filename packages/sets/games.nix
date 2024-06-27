{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = true;
  };

  programs.honkers-railway-launcher.enable = true;
  
  environment.systemPackages = with pkgs; [
    prismlauncher
    protonup-qt
  ];
}

