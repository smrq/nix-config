{
  hostname,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./services/actual-budget.nix
    ./services/gonic.nix
    ./services/jellyfin.nix
    ./services/reverse-proxy.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = hostname;
}
