{ pkgs, username, ... }:

{
  environment.persistence."/nix/persist" = {
    users."${username}".directories = [
    ];
  };

  environment.systemPackages = with pkgs; [
    mpv
    handbrake
    parabolic
  ];
}
