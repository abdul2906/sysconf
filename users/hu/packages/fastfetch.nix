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
          "uptime"
          "packages"
          "cursor"
          "terminal"
          "cpu"
          "gpu"
          "memory"
          "break"
          "colors"
      ];
    };
  };
}

