{
  imports = [
    ../../modules/lan.nix
    ../../modules/podman.nix
  ];

  virtualisation.oci-containers.containers.gonic = {
    environment = {
      GONIC_LISTEN_ADDR = "0.0.0.0:4747";
      GONIC_MUSIC_PATH = "/music,/my-music";
    };
    image = "docker.io/sentriz/gonic:latest";
    autoStart = true;
    ports = [ "4747:4747" ];
    volumes = [
      "/var/lib/gonic/data:/data"
      "/var/lib/gonic/cache:/cache"
      "/var/lib/gonic/playlists:/playlists"
      "/mnt/faerie/Music:/music:ro"
      "/mnt/faerie/My Music:/my-music:ro"
    ];
  };
}
