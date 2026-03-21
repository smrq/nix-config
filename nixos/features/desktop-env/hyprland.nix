{
  username,
  ...
}: {
  programs.hyprland.enable = true;
  # environment.sessionVariables.NIXOS_OZONE_WL = "1"; # hint Electron apps to use Wayland

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "hyprland";
    configHome = "/home/${username}";
  };
}
