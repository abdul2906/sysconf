{ username, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tor-browser
    firefox-esr
  ];

  environment.persistence."/nix/persist" = {
    users."${username}".directories = [
      ".config/mozilla"
    ];
  };
}
