{ pkgs, lib, inputs, config, ... }:

let
  picture-uri = if builtins.hasAttr "wallpaper" inputs.secrets.paths
                  then builtins.toString inputs.secrets.paths.wallpaper
                  else builtins.toString ../../../../../assets/wallpaper.jpg;
in {
  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/background".picture-uri = picture-uri;
    "org/gnome/desktop/background".picture-uri-dark = picture-uri;
    "org/gnome/desktop/screensaver".picture-uri = picture-uri;
    "org/gnome/desktop/interface" = {
      accent-color = "slate";
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/input-sources" = {
      sources = [
        (lib.hm.gvariant.mkTuple ["xkb" "gb"])
        (lib.hm.gvariant.mkTuple ["xkb" "de"])
      ];
    };
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      allow-extension-installation = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        caffeine.extensionUuid
        accent-directories.extensionUuid
        just-perfection.extensionUuid
        quick-settings-tweaker.extensionUuid
        forge.extensionUuid
      ];
      favorite-apps = [
        "firefox-esr.desktop"
        "com.mitchellh.ghostty.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };
    "org/gnome/shell/extensions/forge" = {
      float-always-on-top-enabled = false;
      focus-border-toggle = false;
      move-pointer-to-focus = true;
      stacked-tiling-mode-enable = true;
    };
    "org/gnome/shell/extensions/just-perfection" = {
      calendar = false;
      events-button = false;
      quick-settings-dark-mode = false;
      world-clock = false;
    };
    "org/gnome/shell/extensions/quick-settings-tweaks" = {
      notifications-enabled = false;
    };
    "org/gnome/desktop/wm/preferences" = {
      audible-bell = false;
      num-workspaces = 9;
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      switch-to-application-5 = [];
      switch-to-application-6 = [];
      switch-to-application-7 = [];
      switch-to-application-8 = [];
      switch-to-application-9 = [];
    };
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-7 = ["<Super>7"];
      switch-to-workspace-8 = ["<Super>8"];
      switch-to-workspace-9 = ["<Super>9"];
      move-to-workspace-1 = ["<Super><Shift>1"];
      move-to-workspace-2 = ["<Super><Shift>2"];
      move-to-workspace-3 = ["<Super><Shift>3"];
      move-to-workspace-4 = ["<Super><Shift>4"];
      move-to-workspace-5 = ["<Super><Shift>5"];
      move-to-workspace-6 = ["<Super><Shift>6"];
      move-to-workspace-7 = ["<Super><Shift>7"];
      move-to-workspace-8 = ["<Super><Shift>8"];
      move-to-workspace-9 = ["<Super><Shift>9"];
    };
  };
}
