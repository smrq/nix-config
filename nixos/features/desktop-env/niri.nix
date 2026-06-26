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

  # Enable force rendering background windows
  # https://github.com/niri-wm/niri/pull/2609#issuecomment-4642769618
  nixpkgs.overlays = [
    (final: prev: {
      niri = prev.niri.overrideAttrs (oldAttrs: {
        patches = (oldAttrs.patches or []) ++ [
          (prev.fetchpatch {
            url = "https://github.com/user-attachments/files/28681567/niri-force-render.patch";
            sha256 = "sha256-1uPF2m5qDtyN9udUJDRtgeZQbktA2VHlo4BB+/l3NGU=";
          })
        ];
      });
    })
  ];
}
