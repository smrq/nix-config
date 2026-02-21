{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  home.packages = with pkgs; [
    catppuccinifier-cli
  ];

  catppuccin = {
    enable = true;
    flavor = "frappe";
    accent = "mauve";
    cursors.enable = true;
  };
}
