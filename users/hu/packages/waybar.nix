{ ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
    };

    settings = {
      bar = {
        layer = "top";
        position = "top";
        height = 32;
        output = [
          "DP-1"
        ];

        modules-left = [ "hyprland/workspaces" "hyprland/submap" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "clock" ];
      };
    };
    style = ''
      * {
        all: unset;
        border-radius: 0;
        font-family: "Go Mono Nerd Font";
        font-size: 11pt;
        min-height: 0;
      }

      window#waybar {
        color: #c5c9c5;
        background: #181616;
        border-bottom: 2px solid rgba(53,132,228, 1);
      }

      #workspaces button {
        padding: 0 8pt 0 8pt;
      }

      #workspaces button.active {
        color: #3584e4;
      }

      #clock {
        padding: 0 8pt 0 8pt;
      }
    '';
  };
}

