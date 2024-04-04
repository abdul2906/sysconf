{ pkgs, ... }: 

{
  programs.tmux = {
    enable = true;
    prefix = "C-Space";
    customPaneNavigationAndResize = true;
    baseIndex = 1;
    extraConfig = ''
      bind v split-window -v
      bind c split-window -h
      bind n new-window
    '';
  };
}
