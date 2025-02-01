{ pkgs, username, ... }:

{
  environment.persistence."/nix/persist" = {
    users."${username}".directories = [
      ".local/share/krita"
      ".config/GIMP"
    ];
  };
  
  environment.systemPackages = with pkgs; [
    krita
    gimp
  ];
}
