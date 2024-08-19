{ ... }:

{
  security.sudo.extraConfig = ''
    Defaults  lecture="never"
  '';

  security.apparmor = {
    enable = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "jitsi-meet-1.0.8043"
  ];
}

