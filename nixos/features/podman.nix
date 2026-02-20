{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    podman-compose
    podman-tui
  ];

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      autoPrune.enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    oci-containers = {
      backend = "podman";
    };
  };
}
