{ pkgs, username, ... }:

{
  environment.persistence."/nix/persist" = {
    users."${username}".directories = [
      ".local/share/krita"
      ".config/GIMP"
      ".config/OpenTabletDriver"
    ];
  };

  environment.systemPackages = with pkgs; [
    krita
    gimp
  ];

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };
}
