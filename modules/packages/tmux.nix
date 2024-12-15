{ pkgs, ... }: 

{
  programs.tmux = {
    enable = true;
    customPaneNavigationAndResize = true;
    baseIndex = 1;
    plugins = with pkgs; [
      tmuxPlugins.resurrect
    ];
    extraConfig = ''
      # Enable mouse
      setw -g mouse on

      # Neovim
      set-option -sg escape-time 10
      set-option -g focus-events on
      # https://stackoverflow.com/questions/60309665/neovim-colorscheme-does-not-look-right-when-using-nvim-inside-tmux#comment124479399_60313682
      set-option -ga terminal-overrides ",xterm-256color:Tc"

      # vi mode
      set -g mode-keys vi
      set -g status-keys vi

      # Rebind prefix key to C-a
      set -g prefix C-a
      bind C-a send-prefix
      unbind C-b

      # Clipboard
      set -ga update-environment WAYLAND_DISPLAY
      bind Escape copy-mode
      bind p run-shell 'tmux set-buffer -- "$(wl-paste -t "text/plain;charset=utf-8")"; tmux paste-buffer'
      bind -T copy-mode-vi 'v' send -X begin-selection
      bind -T copy-mode-vi 'y' send -X copy-pipe 'wl-copy'
      set -s set-clipboard off

      # Status bar
      set -g status-style bg=default
      set -g status-fg 4
    '';
  };
}
