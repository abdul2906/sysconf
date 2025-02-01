{ pkgs, username, ... }:

{
  environment.persistence."/nix/persist" = {
    users."${username}".directories = [
      ".local/share/steam_home"
      ".local/share/osu"
    ];
  };

  environment.systemPackages = with pkgs; [
    protonup-qt
    protontricks
    unstable.osu-lazer-bin
  ];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
}
