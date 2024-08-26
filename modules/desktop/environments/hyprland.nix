{ pkgs, ...}:

{
  imports = [
    ../../system/fonts.nix
    ../../packages/waybar.nix
    ../../packages/rofi.nix
    ../../packages/foot.nix
  ];

  environment.systemPackages = with pkgs; [
    hyprpaper
    rofi-wayland
    foot
    wl-clipboard
    nautilus
    pavucontrol
    nvidia-vaapi-driver
  ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    MOZ_DISABLE_RDD_SANDBOX = 1;
    NIXOS_OZONE_WL = 1;
  };

  programs.hyprland = {
    enable = true;
  };

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
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --cmd hyprland";
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
    home.pointerCursor = {
      gtk.enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
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

    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        preload = [
          "/nix/config/assets/wallpaper.jpg"
        ];
        wallpaper = [
          ",/nix/config/assets/wallpaper.jpg"
        ];
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd = {
        enable = true;
        variables = [ "--all" ];
      };

      settings = {
        "$mod" = "SUPER";
        "$terminal" = "foot";
        "$menu" = "rofi -show drun";

        monitor = "DP-1,1920x1080@144,auto,1";

        cursor = {
          no_hardware_cursors = true;
        };

        render = {
          explicit_sync = 0;
        };

        input = {
          kb_layout = "gb:intl";
          follow_mouse = 1;
        };

        general = {
          gaps_in = 3;
          gaps_out = 6;
          border_size = 2;
          layout = "master";
          allow_tearing = true;
          "col.inactive_border" = "rgb(242424)";
          "col.active_border" = "rgb(3584E4)";
        };

        master = {
          mfact = 0.5;
        };

        decoration = {
          rounding = 5;
          blur = {
            enabled = true;
            size = 4;
            passes = 1;
          };
        };

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        bind = [
          "$mod, P, exec, $menu"
          "$mod, RETURN, exec, $terminal"
          ", Scroll_Lock, exec, pavucontrol"
          "$mod, f, exec, nautilus"

          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", Pause, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

          "$mod SHIFT, C, killactive"
          "$mod, SPACE, togglefloating"
          "$mod SHIFT, M, exit,"

          "$mod SHIFT, RETURN, layoutmsg, swapwithmaster"
          "$mod SHIFT, h, layoutmsg, mfact -0.05"
          "$mod SHIFT, l, layoutmsg, mfact +0.05"

          "$mod, h, movefocus, l"
          "$mod, j, movefocus, d"
          "$mod, k, movefocus, u"
          "$mod, l, movefocus, r"

          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"

          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
        ];
      };
    };
  };
}

