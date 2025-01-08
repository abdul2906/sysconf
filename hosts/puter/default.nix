{ config, pkgs, lib, ... }:

{
  imports = [
    ./persist.nix
    ./disko.nix
    ./packages.nix
  ];

  time.timeZone = "Europe/Berlin";

  networking = {
    hostName = "puter";
    useDHCP = true;
  };

  hardware.cpu.amd.updateMicrocode = true;

  services = {
    fstrim.enable = true;
    btrfs.autoScrub.enable = true;
    fwupd.enable = true;
  };

  boot = {
    loader = {
      canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        gfxmodeEfi = "1920x1080";
      };
    };

    tmp.useTmpfs = true;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    supportedFilesystems = [ "btfs" "vfat" "xfs" ];
    kernelModules = [ "kvm-amd" ];
    extraModprobeConfig = "options kvm_amd nested=1";
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
      postDeviceCommands = lib.mkAfter ''
        mkdir /btrfs_tmp
        mount ${config.fileSystems."/".device} /btrfs_tmp
        if [[ -e /btrfs_tmp/root ]]; then
            mkdir -p /btrfs_tmp/old_roots
            timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
            mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
        fi

        delete_subvolume_recursively() {
            IFS=$'\n'
            for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                delete_subvolume_recursively "/btrfs_tmp/$i"
            done
            btrfs subvolume delete "$1"
        }

        for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
            delete_subvolume_recursively "$i"
        done

        btrfs subvolume create /btrfs_tmp/root
        umount /btrfs_tmp
      '';
    };
  };

  fileSystems = {
    # These are system specific. If you have any additional drives that are not
    # your root device you can add and mount them here. Added nofail so that you can
    # install this configuration on a device without it exploding when you don't have
    # these specific partitions.

    "/mnt/vault" = {
      device = "/dev/disk/by-uuid/048d175b-0e3e-4ec7-955b-3d9a45f9f237";
      options = [ "nofail" ];
      fsType = "xfs";
    };

    "/mnt/attic" = {
      device = "/dev/disk/by-uuid/ec32ce36-9f53-4f44-ac8f-2c9163f0b3d7";
      options = [ "nofail" ];
      fsType = "xfs";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  system.stateVersion = "24.11"; # [managed by install.sh] { state version }
}

