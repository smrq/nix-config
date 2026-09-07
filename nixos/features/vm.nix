{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    qemu
    quickemu
    spice-gtk
  ];

  virtualisation.spiceUSBRedirection.enable = true;
}
