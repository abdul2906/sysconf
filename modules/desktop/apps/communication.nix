{ pkgs, ... }:

{
  environment.persistence."/nix/persist".users.hu.directories = [
    ".config/Signal"
    ".config/vesktop"
    ".config/tutanota-desktop"
    ".config/tuta_integration"
    ".config/Element"
  ];

  environment.systemPackages = with pkgs; [
    tutanota-desktop
    signal-desktop
    element-desktop
    vesktop
  ];
}

