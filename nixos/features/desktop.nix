{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bitwarden-desktop
    discord
    feishin
    spotify
  ];

  programs.steam.enable = true;
}