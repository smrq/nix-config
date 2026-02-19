{
  hostname,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./actual-budget.nix
    ./gonic.nix
    ./jellyfin.nix
    ./reverse-proxy.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = hostname;
}
