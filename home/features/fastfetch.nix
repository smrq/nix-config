{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    fastfetch
  ];

  home.file.".config/fastfetch" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/nix-config/dots/fastfetch";
  };
}
