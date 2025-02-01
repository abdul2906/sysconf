{ pkgs, lib, modulesPath, ... }:

{
  imports = [
    ./disko.nix
    ./packages.nix
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  time.timeZone = "Europe/Berlin";

  networking = {
    hostName = "vm";
    useDHCP = lib.mkDefault true;
  };

  boot = {
    loader = {
      grub = {
        enable = true;
        # device = "/dev/sda"; # [managed by install.sh]
        gfxmodeEfi = "1920x1080";
      };
    };

    tmp.useTmpfs = true;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    supportedFilesystems = [ "btfs" "vfat" "xfs" ];
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "ahci"
                                 "usbhid" "usb_storage" "sd_mod" ];
    };
  };

  services = {
    fstrim.enable = true;
    btrfs.autoScrub.enable = true;
  };

  fileSystems = {
    # These are system specific. If you have any additional drives that are not
    # your root device you can add and mount them here. Added nofail so that you can
    # install this configuration on a device without it exploding when you don't have
    # these specific partitions.
  };

  system.stateVersion = "24.11"; # [managed by install.sh]
}

