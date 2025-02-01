{ ... }:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = let
      literally_a_billion_million = 10000000000000;
    in {
      font-family = "Go Mono Nerd Font";
      font-size = 12;
      background-opacity = 0.85;
      scrollback-limit = literally_a_billion_million;
      theme = "Tomorrow Night Burns";
      window-padding-x = 4;
      window-padding-y = 4;
    };
  };
}
