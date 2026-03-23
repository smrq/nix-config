{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bitwarden-desktop
    discord
    feishin
    spotify
    xivlauncher
  ];

  programs.steam.enable = true;
}