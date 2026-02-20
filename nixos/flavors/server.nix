{
  imports = [
    ../features/system/nix.nix
    ../features/system/system.nix
    ../features/system/users.nix

    ../features/lan/avahi.nix
    ../features/lan/manatree.nix
    ../features/lan/wifi.nix

    ../features/server/actual-budget.nix
    ../features/server/gonic.nix
    ../features/server/jellyfin.nix
    ../features/server/openssh.nix
    ../features/server/reverse-proxy.nix
    ../features/server/vscode-server.nix
    
    ../features/ssh-agent.nix
  ];
}
