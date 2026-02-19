{
  imports = [
    ../../../modules/podman.nix
  ];

  virtualisation.oci-containers.containers.actual = {
    image = "ghcr.io/actualbudget/actual:latest";
    autoStart = true;
    ports = [ "5006:5006" ];
    volumes = [
      "/var/lib/actual:/data"
    ];
  };
}
