{
  imports = [
    ../features/system/nix.nix
    ../features/system/system.nix
    ../features/system/users.nix
    
    ../features/lan/avahi.nix
    ../features/lan/wifi.nix
    
    ../features/server/openssh.nix

    ../features/bluetooth.nix
    ../features/desktop.nix
    ../features/dms.nix
    ../features/dolphin.nix
    ../features/fprintd.nix
    ../features/sops.nix
    ../features/stylix.nix
  ];
}
