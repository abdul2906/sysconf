{ pkgs, ... }:

{
  home.file."/home/hu/.config/zsh/conf.d" = {
    source = ./config/conf.d;
    recursive = true;
  };
  home.file."/home/hu/.config/zsh/.zshrc" = {
    text = ''
      #!/usr/bin/env zsh
      SYNTAX_FILE="${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
      FZF_TAB_FILE="${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh"
      AUTOSUGGEST_FILE="${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    '' + (builtins.readFile config/.zshrc);
  };
}

