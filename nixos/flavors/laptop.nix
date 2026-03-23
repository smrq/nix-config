{
  imports = [
    ../features/system/nix.nix
    ../features/system/system.nix
    ../features/system/users.nix
    
    ../features/desktop-env/dms.nix
    ../features/desktop-env/niri.nix

    ../features/lan/avahi.nix
    ../features/lan/wifi.nix
    
    ../features/server/openssh.nix

    ../features/bluetooth.nix
    ../features/desktop.nix
    ../features/dolphin.nix
    ../features/ffxiv.nix
    ../features/fprintd.nix
    ../features/gcr.nix
    ../features/sops.nix
    ../features/stylix.nix
  ];
}
