{
  imports = [
    ../features/system/nix.nix
    ../features/system/system.nix
    ../features/system/users.nix
    
    ../features/desktop-env/hyprland.nix
    ../features/desktop-env/noctalia.nix
    ../features/desktop-env/sddm.nix

    ../features/lan/avahi.nix
    ../features/lan/manatree.nix
    ../features/lan/wifi.nix
    
    ../features/server/openssh.nix

    ../features/azeron.nix
    ../features/bluetooth.nix
    ../features/desktop.nix
    ../features/dolphin.nix
    ../features/fprintd.nix
    ../features/gaming.nix
    ../features/gcr.nix
    ../features/sops.nix
    ../features/stylix.nix
  ];
}
