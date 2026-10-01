{
  config,
  ...
}: {
  # Manual config:
  # - Authenticate with Spotify and Last.fm
  # - Change https://echo.multi-scrobbler.app to http://hostname.local:9078 after redirect to complete authentication

  imports = [
    ../podman.nix
  ];

  virtualisation.oci-containers.containers."multi-scrobbler" = {
    image = "docker.io/foxxmd/multi-scrobbler:latest";
    autoStart = true;
    ports = [ "9078:9078" ];
    volumes = [
      "/var/lib/multi-scrobbler/config:/config"
      "${config.sops.templates."multi-scrobbler-config.json".path}:/config/config.json"
    ];
    environment = {
      TZ = config.time.timeZone;
      BASE_URL = "http://${config.networking.hostName}.local:9078";
    };
  };

  networking.firewall.allowedTCPPorts = [ 9078 ];

  sops = {
    secrets = {
      "multiscrobbler/gonic/token" = { };
      "multiscrobbler/koito/api_key" = { };
      "multiscrobbler/lastfm/api_key" = { };
      "multiscrobbler/lastfm/secret" = { };
      "multiscrobbler/spotify/client_id" = { };
      "multiscrobbler/spotify/client_secret" = { };
    };
    templates = {
      "multi-scrobbler-config.json" = {
        mode = "0400";
        content = ''
          {
            "sources": [
              {
                "type": "spotify",
                "id": "smrqSpotify",
                "name": "smrq Spotify",
                "data": {
                  "clientId": "${config.sops.placeholder."multiscrobbler/spotify/client_id"}",
                  "clientSecret": "${config.sops.placeholder."multiscrobbler/spotify/client_secret"}",
                  "redirectUri": "https://echo.multi-scrobbler.app/callback",
                  "interval": 60
                }
              },
              {
                "type": "endpointlz",
                "id": "smrqGonic",
                "name": "smrq Gonic",
                "data": {
                  "token": "${config.sops.placeholder."multiscrobbler/gonic/token"}"
                }
              }
            ],
            "clients": [
              {
                "type": "lastfm",
                "id": "smrqLastfm",
                "name": "smrq Last.fm",
                "configureAs": "client",
                "data": {
                  "apiKey": "${config.sops.placeholder."multiscrobbler/lastfm/api_key"}",
                  "secret": "${config.sops.placeholder."multiscrobbler/lastfm/secret"}",
                  "redirectUri": "https://echo.multi-scrobbler.app/lastfm/callback"
                }
              },
              {
                "type": "koito",
                "id": "smrqKoito",
                "name": "smrq Koito",
                "configureAs": "client",
                "data": {
                  "token": "${config.sops.placeholder."multiscrobbler/koito/api_key"}",
                  "username": "${config.sops.placeholder."koito/username"}",
                  "url": "https://koito.smrq.net"
                }
              }
            ]
          }
        '';
      };
    };
  };
}