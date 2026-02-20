{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bitwarden-desktop
    discord
    xivlauncher
  ];

  programs.steam.enable = true;
}