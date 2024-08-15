{ ... }:

{
  security.sudo.extraConfig = ''
    Defaults  lecture="never"
  '';

  security.apparmor = {
    enable = true;
  };
}

