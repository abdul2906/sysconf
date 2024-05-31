{ config, pkgs, ... }:

{
  imports = [
    ../../packages/sets/communication.nix
    ../../packages/sets/games.nix
    ./persist.nix
    ./packages/stylix.nix
    ./packages/nh.nix
    ./packages/zsh/zsh.nix
  ];

  environment.variables = {
    EDITOR = "nvim";
  };

  users.users.hu = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    hashedPasswordFile = "/nix/config/secrets/hu/pass";
  };

  # TODO: Figure out a way to run scripts with the user session as a systemd service

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.hu = {
      home.username = "hu";
      home.homeDirectory = "/home/hu";
      home.stateVersion = config.system.stateVersion;

      imports = [
        ./packages/zsh/zsh-home.nix
        ./packages/git.nix
        ./packages/gtk.nix
        # ./packages/tmux.nix
        ./packages/hyprland.nix
        ./packages/foot.nix
        ./packages/firefox.nix
        ./packages/rofi.nix
        ./packages/fastfetch.nix
        ./packages/nvim/neovim.nix
        ./packages/ags/ags.nix
      ];
    };
  };
}

