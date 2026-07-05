{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bitwarden-desktop
    feishin
    qimgv
    spotify
    xed-editor
    yacreader
  ];

  # Required to build bitwarden-desktop
  # https://github.com/NixOS/nixpkgs/issues/526914
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };
}