{
  config,
  ...
}: {
  imports = [
    ../modules/sops.nix
  ];

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services = {
    caddy = {
      enable = true;
      virtualHosts = {
        "budget.smrq.net" = {
          extraConfig = ''
            reverse_proxy http://localhost:5006
            tls internal
          '';
        };
        "media.smrq.net" = {
          extraConfig = ''
            reverse_proxy http://localhost:8096
            tls internal
          '';
        };
        "sub.smrq.net" = {
          extraConfig = ''
            reverse_proxy http://localhost:4747
            tls internal
          '';
        };
      };
    };

    ddns-updater = {
      enable = true;
      environment = {
        SERVER_ENABLED = "no";
        PERIOD = "5m";
        # LOG_LEVEL = "debug";
        # LOG_CALLER = "short";
      };
    };
  };

  sops = {
    secrets = {
      "cloudflare/zone_identifier" = { };
      "cloudflare/edit_zone_dns_token" = { };
    };
    templates = {
      "ddns-updater-config.json" =
        let
          domainSettings = domain: ''
            {
              "provider": "cloudflare",
              "zone_identifier": "${config.sops.placeholder."cloudflare/zone_identifier"}",
              "domain": "${domain}",
              "ttl": 300,
              "token": "${config.sops.placeholder."cloudflare/edit_zone_dns_token"}",
              "ip_version": "ipv4",
              "ipv6_suffix": ""
            }
          '';
        in
        {
          content = ''
            {
              "settings": [
                ${domainSettings "budget.smrq.net"},
                ${domainSettings "media.smrq.net"},
                ${domainSettings "sub.smrq.net"}
              ]
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
}
