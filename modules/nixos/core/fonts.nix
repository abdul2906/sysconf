{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      nerdfonts
      ipafont
      noto-fonts-emoji
      cantarell-fonts
      newcomputermodern
    ];

    fontconfig = {
      enable = true;
      cache32Bit = true;
      subpixel.rgba = "rgb";
      defaultFonts = {
        monospace = [ "Go Mono Nerd Font" ];
      };
    };
  };
}

