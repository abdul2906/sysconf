{ ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.users.hu.extraGroups = [ "libvirtd" ];
  environment.persistence."/nix/persist".directories = [
    "/var/lib/libvirt"
    "/var/log/libvirt"
    "/var/cache/libvirt"
    "/var/log/swtpm/libvirt"
  ];

  home-manager.users.hu = {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
  };
}

