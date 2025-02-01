{ pkgs, lib, username, ... }:

{
  imports = [
    ./disko.nix
    ./packages.nix
  ];

  time.timeZone = "Europe/Berlin";

  networking = {
    hostName = "puter";
    useDHCP = lib.mkDefault true;
  };

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        # Keep "nodev" for efi systems
        device = "nodev";
        efiSupport = true;
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

    "/home/${username}/mounts/vault" = {
      device = "/dev/disk/by-uuid/048d175b-0e3e-4ec7-955b-3d9a45f9f237";
      options = [ "nofail" ];
      fsType = "xfs";
    };

    "/home/${username}/mounts/attic" = {
      device = "/dev/disk/by-uuid/ec32ce36-9f53-4f44-ac8f-2c9163f0b3d7";
      options = [ "nofail" ];
      fsType = "xfs";
    };
  };

  system.stateVersion = "24.11"; # [managed by install.sh] { state version }
}

