{ ... }:

{
  disko.devices = {
    disk = {
      master = {
        type = "disk";
        device = "/dev/vda"; # [managed by install.sh]
        content = {
          type = "gpt";
          partitions = {
            grub_mbr = {
              size = "1M";
              type = "EF02"; # for grub MBR
            };
            boot = {
              size = "1G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/boot";
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
