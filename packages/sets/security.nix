{ ... }:

{
  services.clamav = {
    scanner.enable = true;
    daemon.enable = true;
    fangfrisch.enable = true;
    updater.enable = true;
  };

  security.apparmor = {
    enable = true;
  };
}

