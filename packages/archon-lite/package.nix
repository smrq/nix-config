{
  appimageTools,
  fetchurl,
  lib,
  makeDesktopItem,
}:

let
  pname = "archon-lite";
  version = "9.3.85";

  src = fetchurl {
    url = "https://github.com/RPGLogs/Uploaders-archon-lite/releases/download/v${version}/archon-lite-v${version}.AppImage";
    hash = "sha256-ooNvgbtV6HKgzRLgHZul92NLnEB8oX6fHL6iwfHajVA=";
  };

  desktopItem = makeDesktopItem {
    desktopName = "Archon Lite";
    name = pname;
    exec = pname;
    icon = pname;
    categories = [ "Game" ];
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    mkdir -p $out/share/applications $out/share/icons/hicolor/512x512/apps
    install -Dm644 ${appimageContents}/usr/share/icons/hicolor/512x512/apps/*.png $out/share/icons/hicolor/512x512/apps/${pname}.png
    install -Dm644 ${desktopItem}/share/applications/* $out/share/applications
  '';

  meta = {
    description = "Archon Lite";
    homepage = "https://www.archon.gg";
    downloadPage = "https://www.archon.gg/download";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
  };
}
