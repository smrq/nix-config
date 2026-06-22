{
  imports = [
    ../features/system/nix.nix
    ../features/system/system.nix
    ../features/system/users.nix
    
    ../features/desktop-env/niri.nix
    ../features/desktop-env/noctalia.nix
    ../features/desktop-env/sddm.nix

    ../features/lan/avahi.nix
    ../features/lan/manatree.nix
    ../features/lan/wifi.nix
    
    ../features/server/openssh.nix

    ../features/3d-print.nix
    ../features/audio-production.nix
    ../features/azeron.nix
    ../features/bluetooth.nix
    ../features/desktop.nix
    ../features/ereader.nix
    ../features/ffxiv.nix
    ../features/file-manager.nix
    ../features/gaming.nix
    ../features/keyring.nix
    ../features/llm.nix
    ../features/sops.nix
    ../features/stylix.nix
  ];
}
