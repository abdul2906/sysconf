{ ... }:

{
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
}

