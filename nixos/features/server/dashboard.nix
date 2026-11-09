{
  config,
  pkgs,
  ...
}:
let
  meshTargetsFile = "/etc/prometheus/mesh_targets.json";
  meshDiscoveryScript = pkgs.writeShellScriptBin "update-mesh-targets" ''
    set -euo pipefail

    mkdir -p "$(dirname "${meshTargetsFile}")"

    echo "Scanning network for Google Mesh devices..."

    RAW_DATA=$( \
      ${pkgs.arp-scan}/bin/arp-scan --localnet --plain --retry=3 --timeout=800 2>/dev/null \
      | ${pkgs.gawk}/bin/awk '
        BEGIN {
          loc["38:8b:59:b7:d9:3a"] = "Office"
          loc["38:8b:59:b7:d9:71"] = "Bedroom"
          loc["38:8b:59:b7:fe:23"] = "Living Room"
          loc["f0:72:ea:41:5e:90"] = "Basement"
        }
        {
          if ($2 in loc) {
            print $1 "\t" loc[$2]
          }
        }
      ' \
    )

    if [ -z "$RAW_DATA" ]; then
        echo "[WARNING] No matching Google Mesh devices found during this scan."
        echo "[]" > "${meshTargetsFile}"
        exit 0
    fi

    echo "Devices discovered:"
    echo "$RAW_DATA"

    echo "$RAW_DATA" | ${pkgs.jq}/bin/jq -R -n '
      [inputs
        | split("\t")
        | {
            "targets": [ .[0] ],
            "labels": {
              "job": "google_mesh_devices",
              "location": .[1]
            }
          }
      ]
    ' > "${meshTargetsFile}"

    echo "Written to ${meshTargetsFile}."
    echo "Done."
  '';
in
{
  environment.systemPackages = with pkgs; [
    arp-scan
  ];

  systemd.services.prometheus-mesh-discovery = {
    description = "Scan local network for Google Nest Wifi mesh MAC addresses and update Prometheus targets";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${meshDiscoveryScript}/bin/update-mesh-targets";
      User = "root";
    };
  };

  systemd.timers.prometheus-mesh-discovery = {
    description = "Run Prometheus Mesh Discovery every 5 minutes";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "1m";
      OnUnitActiveSec = "5m";
    };
  };

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
      {
        job_name = "mesh-blackbox";
        metrics_path = "/probe";
        params.module = [ "icmp_ping" ];
        file_sd_configs = [
          {
            files = [ meshTargetsFile ];
            refresh_interval = "1m";
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
