{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.xivlauncher-rb.nixosModules.default
  ];

  environment.systemPackages = with pkgs; [
    ((xivlauncher-rb.override {
      nvngxPath = "${config.hardware.nvidia.package}/lib/nvidia/wine";
    }).overrideAttrs(old: {
      desktopItems = [
        (makeDesktopItem {
          name = "xivlauncher-rb1";
          exec = ''sh -c "XL_PATH=~/.xlcore1 XIVLauncher.Core"'';
          icon = "xivlauncher";
          desktopName = "XIVLauncher-RB 1";
          comment = "Custom launcher for FFXIV with additional patches";
          categories = [ "Game" ];
          startupWMClass = "XIVLauncher.Core";
        })
        (makeDesktopItem {
          name = "xivlauncher-rb2";
          exec = ''sh -c "XL_PATH=~/.xlcore2 XIVLauncher.Core"'';
          icon = "xivlauncher";
          desktopName = "XIVLauncher-RB 2";
          comment = "Custom launcher for FFXIV with additional patches";
          categories = [ "Game" ];
          startupWMClass = "XIVLauncher.Core";
        })
      ];
    }))
  ];

  environment.sessionVariables = {
    DALAMUD_HOME = "~/.xlcore1/dalamud/Hooks/dev";
  };
}
