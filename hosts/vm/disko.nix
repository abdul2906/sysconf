{ ... }:

{
  disko.devices = {
    disk = {
      master = {
        type = "disk";
        device = "/dev/sda"; # [managed by install.sh]
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "efi";
              start = "1M";
              end = "1024M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "umask=0077"
                  "noatime"
                ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" "-L nixos" ];
                postCreateHook = ''
                  TMP_MNT=$(mktemp -d)
                  MNT_PART="/dev/sda2" # [managed by install.sh]
                  mount "$MNT_PART" "$TMP_MNT" -o subvol=/
                  trap 'umount "$TMP_MNT"; rm -rf "$TMP_MNT"' EXIT
                  btrfs subvolume snapshot "$TMP_MNT/root" "$TMP_MNT/blank"
                '';
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = [
                      "noatime"
                      "compress=zstd"
                    ];
                  };

                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "noatime"
                      "compress=zstd"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
