{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bitwarden-desktop
    discord
    spotify
    xivlauncher
  ];

  programs.steam.enable = true;
}