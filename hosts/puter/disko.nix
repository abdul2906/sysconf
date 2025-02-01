{ ... }:

{
  disko.devices = {
    disk = {
      master = {
        type = "disk";
        device = "/dev/nvme0n1"; # [managed by install.sh]
        content = {
          type = "gpt";
          partitions = {
            efi = {
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
                subvolumes = {
                  /* Do not rename the root partition as it'll break impermanence */
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
