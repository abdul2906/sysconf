{ ... }:

{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      accent-color = "teal";
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/input-sources" = {
      sources = "[(gb, de)]";
    };
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };
    "org/gnome/shell" = {
      favorite-apps = "['com.mitchellh.ghostty','org.gnome.Nautilus']";
    };
  };
}
