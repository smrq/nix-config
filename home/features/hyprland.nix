{
  config,
  inputs,
  hostname,
  pkgs,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  home.file.".config/hypr/hyprland-extra.conf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/nix-config/dots/hypr/hyprland-extra.conf";
  };

  home.file.".config/hypr/hyprland-host.conf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/nix-config/dots/hypr/hyprland-${hostname}.conf";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    extraConfig = ''
      source = ./hyprland-extra.conf
      source = ./hyprland-host.conf
    '';
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
      inputs.hyprtasking.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
