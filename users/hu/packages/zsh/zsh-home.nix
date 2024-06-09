{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fzf
    zsh-fzf-tab
    zsh-completions
    zsh-autosuggestions
    zsh-syntax-highlighting
    nix-zsh-completions
    thefuck
  ];

  home.sessionVariables = {
    ZDOTDIR = "${config.xdg.configHome}/zsh";
  };

  home.file."${config.xdg.configHome}/zsh/conf.d" = {
    source = ./config/conf.d;
    recursive = true;
  };

  home.file."${config.xdg.configHome}/zsh/.zshrc" = {
    text = ''
      #!/usr/bin/env zsh
      SYNTAX_FILE="${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

      # On systems that are not on glibc 2.38, loading fzf-tab will fail. This prevents that.
      if [ -f "/lib/x86_64-linux-gnu/libc.so.6" ]; then
        GLIBC_VERSION="$(/lib/x86_64-linux-gnu/libc.so.6 | head -n1 | sed -e 's/.* //g' | rev | cut -c2- | rev)"
        if [ "$GLIBC_VERSION" = "2.38" ]; then
          FZF_TAB_FILE="${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh"
        fi
      else
        FZF_TAB_FILE="${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh"
      fi

      AUTOSUGGEST_FILE="${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    '' + (builtins.readFile config/.zshrc);
  };
}

