{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bitwarden-desktop
    feishin
    spotify
    xivlauncher
  ];

  programs.steam.enable = true;
}