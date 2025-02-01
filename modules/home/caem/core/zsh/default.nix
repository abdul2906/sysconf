{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    lsd
    bat
    fd
    ripgrep
    fzf
    tmux
    fastfetch
    tre-command
    btop
    zsh-completions
    nix-zsh-completions
    git
  ];

  programs.bat = {
    enable = true;
    config = {
      theme = "ansi";
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
    };
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      modules = [
        "title"
        "separator"
        "os"
        "kernel"
        "initsystem"
        "uptime"
        "datetime"
        "packages"
        "terminal"
        "wm"
        "shell"
        "cpu"
        "gpu"
        "memory"
        "break"
        "colors"
      ];
    };
  };

  home.file.".zshenv".enable = false;
  home.file.".config/zsh/conf.d" = {
    source = ./conf.d;
    recursive = true;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = ".config/zsh";
    autocd = true;

    history.size = 10000;
    history.ignoreAllDups = true;
    /* Not persisted on purpose */
    history.path = "${config.xdg.cacheHome}/zsh_history";

    shellAliases = {
      cat = "bat --paging=never --wrap=never --style='changes,snip,numbers'";
      ls = "lsd";
      tree = "tre";
    };

    initExtra = ''
      alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
      alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

      for dotfile in "$ZDOTDIR/conf.d/"*; do
        source "$dotfile"
      done
    '';

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
  };
}
