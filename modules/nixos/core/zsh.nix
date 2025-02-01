{ ... }:

{
  programs.zsh = {
    enable = true;
    shellInit = ''
      export ZDOTDIR=$HOME/.config/zsh
    '';
  };
}
