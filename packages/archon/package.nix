{
  appimageTools,
  fetchurl,
  lib,
  makeDesktopItem,
}:

let
  pname = "archon";
  version = "9.5.0";

  src = fetchurl {
    url = "https://github.com/RPGLogs/Uploaders-archon/releases/download/v${version}/archon-v${version}.AppImage";
    hash = "sha256-5QaxHdRPzRmvDghbCDGdVF7yKwOkyYmrFnbqj+VvOBA=";
  };

  desktopItem = makeDesktopItem {
    desktopName = "Archon";
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
    description = "Archon";
    homepage = "https://www.archon.gg";
    downloadPage = "https://www.archon.gg/download";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
  };
}
