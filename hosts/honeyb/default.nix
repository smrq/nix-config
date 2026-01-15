{
  config,
  inputs,
  pkgs,
  ...
}:
let
  secrets-path = builtins.toString inputs.nix-secrets;
in
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
    firewall.allowedTCPPorts = [
      22
      80
      443
    ];
    wireless = {
      enable = true;
      networks = {
        "Hello Neighbor" = {
          pskRaw = "1f7b7fe3777b373604cc2296105d338b05529aa5bad9b5d8bcdf902122905c17";
        };
      };
    };
  };

  programs.ssh = {
    startAgent = true;
  };

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

  sops = {
    defaultSopsFile = "${secrets-path}/secrets.yaml";
    defaultSopsFormat = "yaml";
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    secrets = {
      "cloudflare/zone_identifier" = { };
      "cloudflare/edit_zone_dns_token" = { };
      "ssh_keys/smrq" = {
        path = "/home/smrq/.ssh/id_ed25519";
        mode = "0400";
        owner = config.users.users.smrq.name;
      };
    };
    templates = {
      "ddns-updater-config.json" = {
        content = ''
          {
            "settings": [{
              "provider": "cloudflare",
              "zone_identifier": "${config.sops.placeholder."cloudflare/zone_identifier"}",
              "domain": "budget.smrq.net",
              "ttl": 300,
              "token": "${config.sops.placeholder."cloudflare/edit_zone_dns_token"}",
              "ip_version": "ipv4",
              "ipv6_suffix": ""
            }]
          }
        '';
      };
    };
  };

  systemd.services.ddns-updater.serviceConfig = {
    LoadCredential = "config.json:${config.sops.templates."ddns-updater-config.json".path}";
    Environment = [
      "CONFIG_FILEPATH=%d/config.json"
    ];
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
