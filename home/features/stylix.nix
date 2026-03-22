{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";

    cursor = {
      name = "Catppuccin-Frappe-Mauve-Cursors";
      package = pkgs.catppuccin-cursors.frappeMauve;
      size = 16;
    };

    fonts = {
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      serif = config.stylix.fonts.sansSerif;

      monospace = {
        package = pkgs.iosevka;
        name = "Iosevka";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes.applications = 10;
    };

    targets.firefox.profileNames = [ "default" ];
  };
}
