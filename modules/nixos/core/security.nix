{ ... }:

{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  /*
   * Sudo is scheduled to be replaced by systemd's run0.
   * The blocker for this is persistent authentication support.
   *
   * https://github.com/systemd/systemd/issues/33366
   * https://github.com/polkit-org/polkit/issues/472
   */
  security.sudo = {
    enable = true;
    execWheelOnly = true;
    extraConfig = ''
      Defaults  lecture="never"
    '';
  };

  security.apparmor.enable = true;
  networking.firewall.enable = true;

  /* Disable the root user */
  users = {
    users.root.hashedPassword = "!";
    mutableUsers = false;
  };

  sops.age.keyFile = "/nix/config/keys.txt";
}
