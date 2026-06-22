{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    calibre
  ];

  # Enable mounting USB devices
  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };
}
