{
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    download-buffer-size = 134217728;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };
}
