{ config, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5cc0482e-ac92-41c7-b2fc-2d9b4a19eeec";
    fsType = "btrfs";
    options = [ "subvol=root" "compress=zstd" "noatime" ];
  };

  fileSystems."/nix" = {
  device = "/dev/disk/by-uuid/5cc0482e-ac92-41c7-b2fc-2d9b4a19eeec";
    fsType = "btrfs";
    options = [ "subvol=nix" "compress=zstd" "noatime" ];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/3012-B13E";
    fsType = "vfat";
  };

  fileSystems."/home/hu/mounts/vault" = {
    device = "/dev/disk/by-uuid/048d175b-0e3e-4ec7-955b-3d9a45f9f237";
    fsType = "xfs";
  };

  fileSystems."/home/hu/mounts/attic" = {
    device = "/dev/disk/by-uuid/ec32ce36-9f53-4f44-ac8f-2c9163f0b3d7";
    fsType = "xfs";
  };

  boot.initrd.availableKernelModules = [ 
    "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.extraModprobeConfig = "options kvm_amd nested=1";
  boot.kernelParams = [
    "nvidia_drm.fbdev=1"
  ];

  boot.initrd.postDeviceCommands = lib.mkAfter ''
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

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

