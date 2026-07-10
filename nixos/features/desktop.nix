{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bitwarden-desktop
    feishin
    kdePackages.ark
    kdePackages.dolphin
    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.kio-extras
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

  services.udev.packages = [ pkgs.libmtp.out ];
}