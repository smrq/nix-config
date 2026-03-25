{ appimageTools, fetchurl, lib }:
let
  pname = "azeron-linux";
  version = "1.5.6";
  src = fetchurl {
    url = "https://github.com/renatoi/azeron-linux/releases/download/v${version}/azeron-software-${version}-x86_64.AppImage";
    hash = "sha256-VFVxhYemMETHlgaKdZG1vRDQZU5WxHiYtb4QYCMjzjo=";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;
  meta = {
    description = "Azeron Software for Linux";
    homepage = "https://github.com/renatoi/azeron-linux";
    downloadPage = "https://github.com/renatoi/azeron-linux/releases";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
  };
}
