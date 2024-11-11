{ pkgs, inputs, ... }:

{
  environment.persistence."/nix/persist".users.hu.directories = [
    ".steam"
    ".local/share/Steam"
    ".local/share/honkers-railway-launcher"
    ".local/share/anime-game-launcher"
    ".local/share/PrismLauncher"
    ".xlcore"
    ".local/share/Euro Truck Simulator 2"
    ".local/share/osu"
    ".local/share/Colossal Order"
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  environment.systemPackages = with pkgs; [
    prismlauncher
    protonup-qt
    xivlauncher
    osu-lazer-bin
    protontricks
  ];

  imports = [ inputs.aagl.nixosModules.default ];
  nix.settings = inputs.aagl.nixConfig;

  programs.anime-game-launcher.enable = true;
}

