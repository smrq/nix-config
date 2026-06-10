{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    reaper
    yabridge
    yabridgectl
    wineWow64Packages.staging
    wineWow64Packages.yabridge
    winetricks
  ];
  security.rtkit.enable = true;

  # https://wiki.nixos.org/wiki/Electric_guitar_interface_setup
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # Required for yabridge/wine VST bridging
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;

    # Global low-latency defaults for native JACK clients
    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;  # Fixed rate avoids resampling latency
        "default.clock.quantum" = 128;      # ~5ms latency at 48kHz
        "default.clock.min-quantum" = 64;   # ~2.5ms latency at 48kHz
        "default.clock.max-quantum" = 512;
      };
    };

    # Crucial: Match low-latency for PulseAudio clients (browsers, Steam/Rocksmith)
    extraConfig.pipewire-pulse."92-low-latency" = {
      "pulse.properties" = {
        "pulse.min.req" = "64/48000";    # Start with 64, not 32, for stability
        "pulse.default.req" = "64/48000";
        "pulse.max.req" = "128/48000";
      };
    };
  };
}
