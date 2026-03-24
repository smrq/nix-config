{
  pkgs,
  username,
  ...
}: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/start-hyprland";
      };
    };
  };

  # environment.sessionVariables.NIXOS_OZONE_WL = "1"; # hint Electron apps to use Wayland

  # services.displayManager.dms-greeter = {
  #   enable = true;
  #   compositor.name = "hyprland";
  #   configHome = "/home/${username}";
  # };
}
