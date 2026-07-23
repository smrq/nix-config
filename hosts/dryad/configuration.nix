{
  inputs,
  hostname,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
    ./prevent-wake.nix
    ../../nixos/flavors/laptop.nix
  ];

  services.fprintd.enable = false;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Lower minimum brightness
  # https://community.frame.work/t/solved-even-lower-screen-brightness/25711/130#p-331338-quick-reference-1
  boot.kernelParams = [ "amdgpu.dcdebugmask=0x40000" ];
  boot.kernelPatches = [
    {
      name = "fw16-drm-panel-backlight-quirks";
      patch = ./drm_panel_backlight_quirks.patch;
    }
  ];

  networking.hostName = hostname;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
