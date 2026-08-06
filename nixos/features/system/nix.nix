{
  config,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    download-buffer-size = 134217728;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    secret-key-files = [
      config.sops.secrets."nix/binary_cache_key".path
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://cache.nixos-cuda.org"
    ];
    trusted-public-keys = [
      "remote-builder-key:YenZJr7mCInsyNSC94E+wKu0V7f976SZdk1fAA5uPnQ="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
  };
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };
  sops.secrets = {
    "nix/binary_cache_key" = { };
  };
}
