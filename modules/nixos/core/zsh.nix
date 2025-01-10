{ ... }:

{
  programs.zsh = {
    enable = true;
    shellInit = ''
      export ZDOTDIR=$HOME/.local/share/zsh
    '';
  };
}
