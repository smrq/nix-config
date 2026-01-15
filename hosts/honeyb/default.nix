{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = with pkgs; [
    podman-compose
    podman-tui
  ];

  networking = {
    hostName = "honeyb";
    firewall.allowedTCPPorts = [ 22 80 443 ];
    wireless = {
      enable = true;
      networks = {
        "Hello Neighbor" = {
          pskRaw = "1f7b7fe3777b373604cc2296105d338b05529aa5bad9b5d8bcdf902122905c17";
        };
      };
    };
  };

  programs.ssh.startAgent = true;

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
      publish = {
        enable = true;
        addresses = true;
      };
    };

    caddy = {
      enable = true;
      virtualHosts = {
        "budget.smrq.net" = {
          extraConfig = ''
            reverse_proxy http://localhost:5006
          '';
        };
      };
    };

    ddns-updater = {
      enable = true;
      environment = {
        SERVER_ENABLED = "no";
        CONFIG_FILEPATH = "/etc/ddns-updater/config.json";
        PERIOD = "5m";
      };
    };

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
    };

    samba = {
      enable = true;
    };
  };

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      autoPrune.enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    oci-containers = {
      backend = "podman";
      containers = {
        actual = {
          image = "ghcr.io/actualbudget/actual:latest";
          autoStart = true;
          ports = [ "5006:5006" ];
          volumes = [
            "/var/lib/actual:/data"
          ];
        };
      };
    };
  };
}
