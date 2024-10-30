{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./persist.nix
    ../../home/default.nix

    ../../modules/desktop/environments/river.nix
    ../../modules/system/basic.nix
    ../../modules/system/security.nix
    ../../modules/desktop/apps/communication.nix
    ../../modules/desktop/apps/multimedia.nix
    ../../modules/system/development.nix
    ../../modules/packages/firefox.nix
    ../../modules/packages/zsh.nix
    ../../modules/packages/fastfetch.nix
  ];

  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
      gfxmodeEfi = "1366x768";
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    supportedFilesystems = [ "btrfs" ];
  };

  networking = {
    hostName = "x220";
    networkmanager.enable = true;
  };

  users.users.hu.extraGroups = [ "networkmanager" ];

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
    # useXkbConfig = true;
  };

  nixpkgs.config.allowUnfree = true;

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

  services.tlp.enable = true;

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.stateVersion = "24.05";
}

