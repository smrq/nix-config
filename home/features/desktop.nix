{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    firefox
    fuzzel
    kitty
    neovim
  ];
  programs.kitty.enable = true;
  programs.vscode.enable = true;
}
