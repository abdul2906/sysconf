{ ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "8x8 center";
        font = "Go Mono Nerd Font:size=12";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      scrollback = {
        lines = 10000;
      };

      colors = {
        alpha = 0.9;
      };
    };
  };
}

