{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    xdotool
    xorg.xkill
    xorg.xinput
    xclip
    yt-dlp
    ffmpeg
  ];
}
