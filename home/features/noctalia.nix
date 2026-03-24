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
          left = [
            { id = "Launcher"; }
            {
              id = "Clock";
              formatHorizontal = "ddd M/dd · h:mm AP";
            }
            { id = "SystemMonitor"; }
            { id = "ActiveWindow"; }
            { id = "MediaMini"; }
          ];
          center = [
            { id = "Workspace"; }
          ];
          right = [
            { id = "Tray"; }
            { id = "NotificationHistory"; }
            { id = "Battery"; }
            { id = "Volume"; }
            { id = "Brightness"; }
            { id = "ControlCenter"; }
          ];
        };
      };

      colorSchemes.predefinedScheme = "Catppuccin";
      #   general = {
      #     avatarImage = "/home/drfoobar/.face";
      #     radiusRatio = 0.2;
      #   };
      location = {
        name = "Milwaukee, WI";
      };
    };
  };
}
