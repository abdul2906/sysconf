{ ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "6x6 center";
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

        foreground = "c5c9c5";
        background = "181616";
        selection-foreground = "c8c093";
        selection-background = "2d4f67";

        regular0 = "0d0c0c";
        regular1 = "c4746e";
        regular2 = "8a9a7b";
        regular3 = "c4b28a";
        regular4 = "8ba4b0";
        regular5 = "a292a3";
        regular6 = "8ea4a2";
        regular7 = "c8c093";

        bright0  = "a6a69c";
        bright1  = "e46876";
        bright2  = "87a987";
        bright3  = "e6c384";
        bright4  = "7fb4ca";
        bright5  = "938aa9";
        bright6  = "7aa89f";
        bright7  = "c5c9c5";

        "16"     = "b6927b";
        "17"     = "b98d7b";
      };
    };
  };
}

