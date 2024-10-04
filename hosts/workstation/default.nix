{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./persist.nix
    ../../home/default.nix

    ../../modules/desktop/environments/kde.nix
    ../../modules/system/basic.nix
    ../../modules/system/security.nix
    ../../modules/desktop/apps/communication.nix
    ../../modules/desktop/apps/games.nix
    ../../modules/desktop/apps/multimedia.nix
    ../../modules/system/virtualisation.nix
    ../../modules/system/development.nix
    ../../modules/packages/firefox.nix
    ../../modules/packages/zsh.nix
    ../../modules/packages/fastfetch.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    gfxmodeEfi = "1920x1080";
  };
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.supportedFilesystems = [ "btrfs" "xfs" ];

  networking = {
    hostName = "workstation";
    enableIPv6 = false;
  };

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
    # useXkbConfig = true;
  };

  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.stateVersion = "23.11";
}

