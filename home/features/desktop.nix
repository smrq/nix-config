{
  pkgs,
  ...
}: {
  programs = {
    firefox.enable = true;
    fuzzel.enable = true;
    neovim.enable = true;
  };
}
