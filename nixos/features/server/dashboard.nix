{
  config,
  pkgs,
  ...
}: {
  services.prometheus = {
    enable = true;
    port = 3020;
    exporters = {
      node = {
        enable = true;
        port = 3021;
        enabledCollectors = [ "systemd" ];
      };
      blackbox = {
        enable = true;
        port = 3022;
        configFile = pkgs.writers.writeYAML "blackbox.yml" {
          modules = {
            icmp_ping = {
              prober = "icmp";
              timeout = "10s";
              icmp = {
                preferred_ip_protocol = "ip4";
              };
            };
          };
        };
      };
    };
    scrapeConfigs = [
      {
        job_name = "${config.networking.hostName}-node";
        static_configs = [
          {
            targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
          }
        ];
      }
      {
        job_name = "${config.networking.hostName}-blackbox";
        metrics_path = "/probe";
        params.module = [ "icmp_ping" ];
        static_configs = [
          {
            targets = [ "1.1.1.1" ];
          }
        ];
        relabel_configs = [
          {
            source_labels = [ "__address__" ];
            target_label = "__param_target";
          }
          {
            source_labels = [ "__param_target" ];
            target_label = "instance";
          }
          {
            target_label = "__address__";
            replacement = "127.0.0.1:${toString config.services.prometheus.exporters.blackbox.port}";
          }
        ];
      }
    ];
  };

  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 4455;
        domain = "dashboard.smrq.net";
      };
      security = {
        secret_key = "$__file{${config.sops.secrets."grafana/secret".path}}";
        admin_user = "admin";
        admin_password = "$__file{${config.sops.secrets."grafana/admin_password".path}}";
      };
    };

    provision = {
      enable = true;

      datasources.settings.datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          url = "http://127.0.0.1:${toString config.services.prometheus.port}";
          isDefault = true;
          editable = false;
        }
      ];
    };
  };

  systemd.services.prometheus-blackbox-exporter.serviceConfig = {
    AmbientCapabilities = [ "CAP_NET_RAW" ];
    CapabilityBoundingSet = [ "CAP_NET_RAW" ];
  };

  sops = {
    secrets = {
      "grafana/secret" = {
        owner = "grafana";
        group = "grafana";
        mode = "0400";
      };
      "grafana/admin_password" = {
        owner = "grafana";
        group = "grafana";
        mode = "0400";
      };
    };
  };
}
