{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = true;
  };

  nix.settings = {
    substituters = [ "https://ezkea.cachix.org" ];
    trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
  };
#  programs.honkers-railway-launcher.enable = true;
  programs.sleepy-launcher.enable = true;
  
  environment.systemPackages = with pkgs; [
    prismlauncher
    protonup-qt
    xivlauncher
    osu-lazer-bin
  ];
}

