{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    usbutils
  ];

  programs = {
    firefox.enable = true;
    fuzzel.enable = true;
  };
}
