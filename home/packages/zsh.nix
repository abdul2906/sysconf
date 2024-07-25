{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fzf
    thefuck
    zsh-fzf-tab
    zsh-completions
    zsh-autosuggestions
    zsh-syntax-highlighting
    nix-zsh-completions
    zsh-nix-shell
  ];

  home.sessionVariables = {
    ZDOTDIR = "${config.xdg.configHome}/zsh";
  };

  home.file."${config.xdg.configHome}/zsh/conf.d" = {
    source = ../../dotfiles/zsh/conf.d;
    recursive = true;
  };

  home.file."${config.xdg.configHome}/zsh/.zshrc" = {
    text = ''
      #!/usr/bin/env zsh

      SYNTAX_PLUGIN="${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
      AUTOSUGGEST_PLUGIN="${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
      NIX_SHELL_PLUGIN="${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh"
      FZF_TAB_PLUGIN="${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh"
    '' + (builtins.readFile ../../dotfiles/zsh/.zshrc);
  };
}

