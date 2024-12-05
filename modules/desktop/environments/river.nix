{ pkgs, ...}:

{
  imports = [
    ../../system/fonts.nix
    ../../packages/foot.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {
      sandbar = prev.sandbar.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "kolunmi";
          repo = "sandbar";
          rev = "e64a8b788d086cdf4ec44b51e62bdc7b6b5f8165";
          hash = "sha256-dNYYlm5CEdnvLjskrPJgquptIQpYgU+gxOu+bt+7sbw=";
        };
      });
    })
  ];

  environment.systemPackages = with pkgs; [
    foot # to be replaced with ghostty
    wl-clipboard
    sandbar
    pamixer
    pavucontrol
    tofi
    swaybg
    fnott
    slurp
    wf-recorder
    grim
    libnotify
    seahorse
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };

  programs.river.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYHangup = true;
    TTYVTDisallocate = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --cmd river";
        user = "greeter";
      };
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  home-manager.users.hu = {
    home.file."/home/hu/.config/tofi/config" = {
      text = ''
        width = 100%
        height = 100%
        border-width = 0
        outline-width = 0
        padding-left = 35%
        padding-top = 35%
        result-spacing = 25
        num-results = 5
        font = Go Mono Nerd Font
        background-color = #000A
      '';
    };

    home.file."/home/hu/.config/river/bar" = {
      text = ''
        #!/usr/bin/env sh

        FIFO="$XDG_RUNTIME_DIR/sandbar"
        [ -e "$FIFO" ] && rm -f "$FIFO"
        mkfifo "$FIFO"

        while cat "$FIFO"; do :; done | sandbar \
            -hide-normal-mode \
            -no-layout \
            -font "Go Mono Nerd Font:12" \
            -active-fg-color "#bbbbbb" \
            -active-bg-color "#222222" \
            -inactive-fg-color "#888888" \
            -inactive-bg-color "#111111" \
            -urgent-fg-color "#ab5656" \
            -title-fg-color "#bbbbbb" \
            -title-bg-color "#222222"
      '';
      executable = true;
    };

    home.file."/home/hu/.config/river/status" = {
      text = ''
        #!/usr/bin/env sh

        FIFO="$XDG_RUNTIME_DIR/sandbar"
        [ -e "$FIFO" ] || mkfifo "$FIFO"

        bat () {
            read -r bat_status < /sys/class/power_supply/BAT0/status
            read -r bat_capacity < /sys/class/power_supply/BAT0/capacity
            case "$bat_status" in
                "Charging")
                    bat_status="󱟦"
                    ;;
                "Discharging")
                    bat_status="󱟤"
                    ;;
                "Full")
                    bat_status="󱟢"
                    ;;
                "Not charging")
                    bat_status="󱞜"
                    ;;
                "Empty")
                    bat_status="󱟨"
                    ;;

            esac
            bat="[$bat_status $bat_capacity]"
        }

        datetime () {
            dat="[$(date "+%H:%M")]"
        }

        while true; do
            if [ -d /sys/class/power_supply/BAT0/ ]; then
                bat
            fi
            datetime

            echo "all status $bat$dat" > "$FIFO"
            sleep 20
        done
      '';
      executable = true;
    };

    wayland.windowManager.river = {
      enable = true;
      systemd.enable = true;
      settings = {
        map.normal = {
          "Super+Shift Return" = "spawn foot";
          "Super+Shift C" = "close";
          "Super J" = "focus-view next";
          "Super K"= "focus-view previous";
          "Super+Shift J" = "swap next";
          "Super+Shift K" = "swap previous";
          "Super Space" = "toggle-float";
          "Super+Shift R" = "spawn ~/.config/river/init";
          "Super+Shift Q" = "exit";
          "Super H" = "send-layout-cmd rivertile 'main-ratio -0.05'";
          "Super L" = "send-layout-cmd rivertile 'main-ratio +0.05'";
          "Super P" = "spawn '$(tofi-drun)'";
          "Super S" = "spawn ~/.config/river/screenshot.sh";
          "Super O" = "spawn ~/.config/river/screencast.sh";
          "Super+Shift O" = "spawn ~/.config/river/screencast.sh audio";

          "None XF86AudioRaiseVolume" = "spawn 'pamixer -i 5'";
          "None XF86AudioLowerVolume" = "spawn 'pamixer -d 5'";
          "None XF86AudioMute" = "spawn 'pamixer --toggle-mute'";
          "None XF86AudioMicMute" = "spawn 'pamixer --default-source --toggle-mute'";
        };

        map-pointer.normal = {
          "Super BTN_LEFT" = "move-view";
          "Super BTN_RIGHT" = "resize-view";
        };

        keyboard-layout = "de";
        default-layout = "rivertile";
        rule-add."-app-id" = {
          "'bar'" = "csd";
        };
        set-repeat = "50 300";
        spawn = [
          "'swaybg -i /nix/config/assets/wallpapers/river.png'"
          "/home/hu/.config/river/status"
          "/home/hu/.config/river/bar"
          "'fnott --config /home/hu/.config/fnott/fnott.conf.ini'"
          "'gnome-keyring-daemon --start'"
        ];
        border-width = 1;
        border-color-focused = "0x333333";
        border-color-unfocused = "0x000000";
      };

      extraConfig = "
        for i in $(seq 1 9); do
          tags=$((1 << ($i - 1)))
          riverctl map normal Super $i set-focused-tags $tags
          riverctl map normal Super+Shift $i set-view-tags $tags
        done
        rivertile -main-ratio 0.5 -view-padding 0 -outer-padding 0 
      ";
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };

      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
    };

    home.file."/home/hu/.config/river/screenshot.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env sh

        mkdir -p "$HOME/images/screenshots"
        screenshot_file="$HOME/images/screenshots/$(date +%s).png"
        area="$(slurp)"
        if [ "$area" = "selection cancelled" ]; then
            exit 0
        fi
        grim -g "$area" "$screenshot_file"
        notify-send "Screenshot saved" "$screenshot_file"
        wl-copy < "$screenshot_file"
      '';
    };

    home.file."/home/hu/.config/river/screencast.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env sh

        if [ -n "$(pidof wf-recorder)" ]; then
          kill -s SIGINT $(pidof wf-recorder)
          notify-send "Screencast saved" "$(cat "$HOME/.cache/last_screencast")"
          wl-copy < "$(cat "$HOME/.cache/last_screencast")"
          exit 0
        fi

        mkdir -p "$HOME/videos/screencasts/"
        screencast_file="$HOME/videos/screencasts/$(date +%s).mp4"
        area="$(slurp)"
        if [ "$area" = "selection cancelled" ]; then
            exit 0
        fi

        echo "$screencast_file" > "$HOME/.cache/last_screencast"
        if [ "$1" = "audio" ]; then
          wf-recorder -g "$area" --file="$screencast_file" --audio
        else
          wf-recorder -g "$area" --file="$screencast_file"
        fi
      '';
    };

    services.fnott = {
      enable = true;
      configFile = "/home/hu/.config/fnott/fnott.conf.ini";
    };

    home.file."/home/hu/.config/fnott/fnott.conf.ini" = {
      text = ''
        title-font=Go Mono Nerd Font
        body-font=Go Mono Nerd Font

        background=111111ff
        title-color=888888ff
        body-color=888888ff
        summary-color=888888ff

        default-timeout=10
      '';
    };
  };
}

