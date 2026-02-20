{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    firefox
    fuzzel
    neovim
  ];

  programs.vscode.enable = true;
}
