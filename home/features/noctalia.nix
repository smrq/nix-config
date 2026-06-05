{ pkgs, inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        keybind-cheatsheet = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 2;
    };
    settings = {
      bar = {
        density = "comfortable";
        position = "bottom";
        widgets = {
          # https://github.com/noctalia-dev/noctalia-shell/blob/2461f871a602f9a5688b5b01dc19c6309dd0d519/Services/UI/BarWidgetRegistry.qml#L80
          left = [
            { id = "Launcher"; }
            {
              id = "Clock";
              formatHorizontal = "ddd M/dd · h:mm AP";
              tooltipFormat = "ddd M/dd · h:mm AP";
            }
            { id = "SystemMonitor"; }
            { id = "MediaMini"; }
          ];
          center = [
            {
              id = "Taskbar";
              colorizeIcons = false;
              showPinnedApps = false;
              showTitle = true;
            }
          ];
          right = [
            { id = "Workspace"; }
            { id = "Tray"; }
            { id = "NotificationHistory"; }
            { id = "Battery"; }
            { id = "Volume"; }
            # { id = "Brightness"; }
            { id = "ControlCenter"; }
          ];
        };
      };

      dock = {
        position = "top";
        dockType = "attached";
        showLauncherIcon = true;
        launcherPosition = "start";
        groupApps = true;
        showDockIndicator = true;
      };

      colorSchemes.predefinedScheme = "Catppuccin";
      #   general = {
      #     avatarImage = "/home/drfoobar/.face";
      #     radiusRatio = 0.2;
      #   };
      location = {
        name = "Milwaukee, WI";
        useFahrenheit = true;
        use12hourFormat = true;
      };
    };
  };
}
