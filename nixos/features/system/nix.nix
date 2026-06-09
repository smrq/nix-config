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
    trusted-public-keys = [
      "remote-builder-key:YenZJr7mCInsyNSC94E+wKu0V7f976SZdk1fAA5uPnQ="
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
