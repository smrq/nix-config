{
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    (pkgs.callPackage ./package.nix { })
  ];

  # nixpkgs.overlays = [
  #   (final: prev:
  #   let
  #     pname = "xivlauncher-rb";
  #     version = "1.3.1.2";
  #   in {
  #     xivlauncher = prev.xivlauncher.overrideAttrs (old: {
  #       inherit pname version;

  #       src = prev.fetchFromGitHub {
  #         owner = "rankynbass";
  #         repo = "XIVLauncher.Core";
  #         rev = "rb-v${version}";
  #         hash = "sha256-f2Nia+XRCY8FtjjdZajkpKBKnFVtWYzNpr2ht74jsy8=";
  #         fetchSubmodules = true;
  #       };

  #       dotnetFlags = [
  #         "-p:BuildHash=${version}"
  #         "-p:PublishSingleFile=false"
  #       ];

  #       postPatch =
  #         builtins.replaceStrings [ "AriaHttpPatchAcquisition.cs" ] [ "AriaPatchAcquisition.cs" ]
  #           old.postPatch;
  #     });
  #   })
  # ];
}
