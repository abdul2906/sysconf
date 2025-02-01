{ pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [
    tidal-hifi
  ];

  environment.persistence."/nix/persist" = {
    users."${username}".directories = [
      ".config/tidal-hifi"
    ];
  };
}
