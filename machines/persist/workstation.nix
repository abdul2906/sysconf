{ config, lib, pkgs, impermanence, ... }:

{
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      { 
        directory = "/var/lib/colord";
	user = "colord";
	group = "colord";
	mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/machine-id"
    ];
  };
}
