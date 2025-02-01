{ ... }:

{
  /* https://files.catbox.moe/s5diss.mp4 */
  systemd.extraConfig = ''
    DefaultTimeoutStopSpec=5s
  '';
}
