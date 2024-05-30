{ pkgs, ... }:

{
  stylix.targets.gtk.enable = false;
  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark-BL-LB";
      package = pkgs.gruvbox-gtk-theme;
    };
    iconTheme = {
      name = "elementary";
      package = pkgs.pantheon.elementary-icon-theme;
    };
  };
}

