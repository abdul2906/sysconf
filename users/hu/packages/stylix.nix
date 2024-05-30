{ pkgs, ... }:

{
  stylix = {
    image = ../../../assets/wallpaper.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    fonts = {
      monospace = {
        package = pkgs.nerdfonts;
        name = "Go Mono Nerd Font";
      };
    };

    fonts = {
      sizes = {
        terminal = 13;
        popups = 13;
        applications = 10;
      };
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    targets = {
      grub.enable = false;
      gtk.enable = false;
    };

    opacity = {
      terminal = 0.9;
      popups = 0.9;
    };
  };
}

