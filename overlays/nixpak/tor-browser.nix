# Refer to firefox.nix in the same directory for more information and a
# better version of this. This is barebones on purpose.

# TODO: Fix file permissions. Right now it for some reason can't download anywhere.

{ ... }: final: prev: {
  tor-browser = let
    sandboxed-tor-browser = prev.mkNixPak {
      config = { sloth, ... }: {
        app.package = prev.tor-browser;
        app.binPath = "bin/tor-browser";
        flatpak.appId = "org.torproject.tor-browser";

        dbus.policies = {
          "org.a11y.Bus" = "talk";
          "org.gnome.SessionManager" = "talk";
          "org.freedesktop.ScreenSaver" = "talk";
          "org.gtk.vfs.*" = "talk";
          "org.gtk.vfs" = "talk";
          "org.freedesktop.Notifications" = "talk";
          "org.freedesktop.portal.FileChooser" = "talk";
          "org.freedesktop.portal.Settings" = "talk";
          "org.torproject.tor-browser.*" = "own";
          "org.freedesktop.DBus" = "talk";
          "org.freedesktop.DBus.*" = "talk";
          "org.freedesktop.portal.*" = "talk";
          "org.freedesktop.NetworkManager" = "talk";
          "org.freedesktop.FileManager1" = "talk";
        };

        gpu.enable = true;
        gpu.provider = "bundle";

        bubblewrap = let
          envSuffix = envKey: sloth.concat' (sloth.env envKey);
        in {
          bind.dev = [ "/dev/shm" ];

          bind.rw = [
            (envSuffix "XDG_RUNTIME_DIR" "/gvfsd")
            [(sloth.mkdir "/tmp/tor-browser") (sloth.concat' sloth.homeDir "/.tor project")]
          ];

          bind.ro = [
            "/sys/bus/pci"
            ["${prev.tor-browser}/lib/firefox" "/app/etc/firefox"]
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
    sandboxed-tor-browser.config.env;
}
