{ pkgs, ... }:

{
  environment.persistence."/nix/persist".users.hu.directories = [
    ".config/OpenTabletDriver"
  ];

  environment.systemPackages = with pkgs; [
    mpv
    imagemagick
    ffmpeg-full
    yt-dlp
    (pkgs.symlinkJoin {
      name = "flowblade";
      paths = [ pkgs.flowblade ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        rm "$out/bin/flowblade"
        echo "#!/bin/sh" > "$out/bin/flowblade" 
        echo "SDL12COMPAT_NO_QUIT_VIDEO=1 \
              GDK_BACKEND=x11 \
              SDL_VIDEODRIVER=x11 \
              ${pkgs.flowblade}/bin/flowblade" >> "$out/bin/flowblade"
        chmod 555 "$out/bin/flowblade"
      '';
    })
    gimp
    inkscape
    krita
    tidal-hifi
  ];

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };
}

