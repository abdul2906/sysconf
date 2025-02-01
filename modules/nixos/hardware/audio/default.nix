{ ... }:

{
  boot.kernelParams = [ "preempt=full" ];
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;

    # Reduce latency
    # https://wiki.nixos.org/wiki/PipeWire#Low-latency_setup
    extraConfig = let
      rate = builtins.toString 48000;

      # The default value in the wiki is 32 but might result in crackling audio.
      # If you get audio crackling try increasing this value until it's gone.
      quantum = builtins.toString 128;
    in {
      pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = "${rate}";
          "default.clock.quantum" = "${quantum}";
          "default.clock.min-quantum" = "${quantum}";
          "default.clock.max-quantum" = "${quantum}";
        };
      };

      pipewire-pulse."92-low-latency" = {
        "context.properties" = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = { };
          }
        ];
        "pulse.properties" = {
          "pulse.min.req" = "${quantum}/${rate}";
          "pulse.default.req" = "${quantum}/${rate}";
          "pulse.max.req" = "${quantum}/${rate}";
          "pulse.min.quantum" = "${quantum}/${rate}";
          "pulse.max.quantum" = "${quantum}/${rate}";
        };
        "stream.properties" = {
          "node.latency" = "${quantum}/${rate}";
          "resample.quality" = 1;
        };
      };
    };
  };
}
