# Shamelessly stolen most parts from here:
# https://github.com/ryan4yin/nix-config/blob/7deed26cc5a3af2072b8c89a688f265607babc80/hardening/nixpaks/firefox.nix
# https://github.com/schizofox/schizofox/blob/cdf69b2a445ff12680657a3bd44ce7c406bf2ae6/flake/modules/home-manager/default.nix

# NOTE: This overlay package is not compatible with the `programs.firefox` module
#       for both NixOS and home-manager. If you want to modify the configuration of
#       Firefox, you have to do it through modifying the overrides for the intermediary
#       package below. This configuration already sets sane defaults so it shouldn't be needed
#       but it is there in case you want it.

{ cfgPath, ... }: final: prev: {
  firefox-esr = let
    intermediary-firefox-esr = let
      policiesFile = "${cfgPath}/modules/nixos/multimedia/web/firefox/policies.nix";
      prefsFile = "${cfgPath}/modules/nixos/multimedia/web/firefox/preferences.nix";
    in prev.firefox-esr.override {
      extraPolicies = import policiesFile;
      extraPrefs = import prefsFile;
    };

    sandboxed-firefox-esr = prev.mkNixPak {
      config = { sloth, ... }: {
        app.package = intermediary-firefox-esr;
        app.binPath = "bin/firefox-esr";
        flatpak.appId = "org.mozilla.firefox";

        dbus.policies = {
          "org.a11y.Bus" = "talk";
          "org.gnome.SessionManager" = "talk";
          "org.freedesktop.ScreenSaver" = "talk";
          "org.gtk.vfs.*" = "talk";
          "org.gtk.vfs" = "talk";
          "org.freedesktop.Notifications" = "talk";
          "org.freedesktop.portal.FileChooser" = "talk";
          "org.freedesktop.portal.Settings" = "talk";
          "org.mpris.MediaPlayer2.firefox.*" = "own";
          "org.mozilla.firefox.*" = "own";
          "org.mozilla.firefox_beta.*" = "own";
          "org.freedesktop.DBus" = "talk";
          "org.freedesktop.DBus.*" = "talk";
          "ca.desrt.dconf" = "talk";
          "org.freedesktop.portal.*" = "talk";
          "org.freedesktop.NetworkManager" = "talk";
          "org.freedesktop.FileManager1" = "talk";
        };

        gpu.enable = true;
        gpu.provider = "bundle";
        fonts.enable = true;
        locale.enable = true;
        etc.sslCertificates.enable = true;

        bubblewrap = let
          envSuffix = envKey: sloth.concat' (sloth.env envKey);
        in {
          bind.dev = [ "/dev/shm" ];
          tmpfs = [ "/tmp" ];

          bind.rw = [
            (envSuffix "XDG_RUNTIME_DIR" "/at-spi/bus")
            (envSuffix "XDG_RUNTIME_DIR" "/gvfsd")
            (envSuffix "XDG_RUNTIME_DIR" "/pulse")
            (envSuffix "XDG_RUNTIME_DIR" "/doc")
            (envSuffix "XDG_RUNTIME_DIR" "/dconf")

            [(sloth.mkdir (sloth.concat' sloth.xdgConfigHome "/mozilla")) (sloth.concat' sloth.homeDir "/.mozilla")]
          ];

          bind.ro = [
            "/sys/bus/pci"
            "/etc/resolv.conf"
            "/etc/localtime"
            "/etc/fonts"
            ["${intermediary-firefox-esr}/lib/firefox" "/app/etc/firefox"]
            (sloth.concat' sloth.xdgConfigHome "/dconf")
            (sloth.concat' sloth.xdgConfigHome "/gtk-2.0")
            (sloth.concat' sloth.xdgConfigHome "/gtk-3.0")
            (sloth.concat' sloth.xdgConfigHome "/gtk-4.0")
            (sloth.concat' sloth.xdgConfigHome "/dconf")
          ];

          sockets = {
            x11 = false;
            wayland = true;
            pipewire = true;
          };
        };
      };
    };
  in
    sandboxed-firefox-esr.config.env;
}
