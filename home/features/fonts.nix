{
  pkgs,
  ...
}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    iosevka
    nerd-fonts.symbols-only
  ];
}
