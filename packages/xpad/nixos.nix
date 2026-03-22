{
  config,
  ...
}: {
  boot.extraModulePackages = [
    (config.boot.kernelPackages.callPackage ./package.nix {})
  ];

  boot.kernelModules = [
    "xpad"
  ];
}
