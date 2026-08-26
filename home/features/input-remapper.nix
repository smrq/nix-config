{
  config,
  ...
}: {
  home.file.".config/input-remapper-2" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/nix-config/dots/input-remapper";
  };
}
