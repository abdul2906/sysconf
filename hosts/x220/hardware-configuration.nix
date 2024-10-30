{ config, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e0b531cf-b575-4579-b866-9b7265e01b0a";
    fsType = "btrfs";
    options = [ "subvol=root" "compress=zstd" "noatime" "ssd" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/e0b531cf-b575-4579-b866-9b7265e01b0a";
    fsType = "btrfs";
    options = [ "subvol=nix" "compress=zstd" "noatime" "ssd" ];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/bfe6e556-44e9-427f-9ae6-eddae6c62298";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."vg".device = "/dev/disk/by-uuid/92b4f484-2c00-47e7-baf6-9f396883e231";
  boot.initrd.availableKernelModules = [ 
    "ehci_pci" "ahci" "xhci_pci" "usb_storage" "sd_mod" "sdhci_pci"
  ];
  boot.kernelModules = [ "kvm-intel" ];
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
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

