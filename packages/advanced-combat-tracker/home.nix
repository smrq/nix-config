{
  pkgs,
  ...
}: {
  home.file = {
    ".xlcore/wineprefix/drive_c/Program Files (x86)/Advanced Combat Tracker" = {
      source = pkgs.callPackage ./package.nix { };
      recursive = true;
    };
  };
}
