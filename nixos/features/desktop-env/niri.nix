{
  pkgs,
  ...
}: {
  programs.niri.enable = true;
  programs.xwayland.enable = true;
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];
  
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome pkgs.xdg-desktop-portal-gtk ]; 
    config = {
      common = {
        default = [ "gnome" "gtk" ];
      };
    };
  };
}
