{
  config,
  username,
  ...
}: {
  services.syncthing = {
    enable = true;

    user = username;
    group = "users";
    configDir = "/home/${username}/.config/syncthing";

    openDefaultPorts = true;
    guiPasswordFile = config.sops.secrets."syncthing/gui_password".path;

    cert = config.sops.secrets."syncthing/devices/${config.networking.hostName}/cert".path;
    key = config.sops.secrets."syncthing/devices/${config.networking.hostName}/key".path;

    overrideDevices = true;
    overrideFolders = true;

    settings = {
      gui.user = "smrq";
      devices = {
        "dryad" = {
          id = "DHJCM34-YNLWELG-EAKSVVD-AXLQIMR-VUM7TZZ-P65PYUN-6PIQZUD-WNIYMA4";
        };
        "honeyb" = {
          id = "MZIFULL-N6RSWIY-TCPG27G-OP4FH62-DU7ZEMX-LPM7U5N-I44ADGH-CWT6VQT";
        };
        "pixel-xl" = {
          id = "L4RYEB3-XSTOJDO-I6HJY4D-OYUY32I-X3HLWGR-EJQPJHI-XALIMNW-XNT5OQG";
        };
        "salamando" = {
          id = "25LM7FZ-QSSQKWU-RPKNUC6-BJN7VYQ-PLERMA7-FAZQCXB-BGSZCXW-O6WXPQ3";
        };
        "unit-10" = {
          id = "3VT4CBW-N2YHJ5Z-F4ZKUEQ-HTJWXS7-E6EXSOU-THZVHXP-WFDOK2M-Y6GY2AO";
        };
      };
      folders = {
        "Obsidian" = {
          path = "/home/${username}/Documents/Obsidian";
          devices = [
            "dryad"
            "honeyb"
            "salamando"
            "unit-10"
          ];
        };
      };
    };
  };

  sops.secrets = {
    "syncthing/gui_password" = {
      owner = config.services.syncthing.user;
      group = config.services.syncthing.group;
    };
    "syncthing/devices/${config.networking.hostName}/cert" = {
      owner = config.services.syncthing.user;
      group = config.services.syncthing.group;
    };
    "syncthing/devices/${config.networking.hostName}/key" = {
      owner = config.services.syncthing.user;
      group = config.services.syncthing.group;
    };
  };
}
