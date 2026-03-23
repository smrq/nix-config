{ fetchzip, lib }:
let
  pname = "advanced-combat-tracker";
  version = "3.8.5.288";
  url = "https://github.com/EQAditu/AdvancedCombatTracker/releases/download/${version}/ACTv3.zip";
in
fetchzip {
  inherit pname version url;
  hash = "sha256-uKgchCJMgD8UfdfKBBroPTtfLYPbJeCe7ILyb4LpLZw=";
  stripRoot = false;
  meta = {
    description = "Advanced Combat Tracker";
    homepage = "https://advancedcombattracker.com/";
    downloadPage = "https://github.com/EQAditu/AdvancedCombatTracker/releases";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
