{
  config,
  pkgs,
  ...
}: {
  home.file.".config/hypr" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/nix-config/dots/hypr";
  };

  wayland.windowManager.hyprland.systemd.enable = false;
}
