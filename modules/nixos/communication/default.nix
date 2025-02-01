{ pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [
    tutanota-desktop
    signal-desktop
    element-desktop
    vesktop
  ];

  environment.persistence."/nix/persist" = {
    users."${username}" = {
      directories = [
        ".config/Signal"
        ".config/vesktop"
        ".config/tutanota-desktop"
        ".config/tuta_integration"
        ".config/Element"
      ];
    };
  };
}
