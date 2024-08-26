{ pkgs, ... }:

{
  home-manager.users.hu = {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      theme = "sidebar";
    };
  };
}
