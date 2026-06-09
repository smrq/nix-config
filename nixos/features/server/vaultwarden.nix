{
  config,
  ...
}: {
  services.vaultwarden = {
    enable = true;
    backupDir = "/var/local/vaultwarden/backup";
    environmentFile = config.sops.secrets."vaultwarden/env".path;
    config = {
      DOMAIN = "https://bitwarden.smrq.net";
      SIGNUPS_ALLOWED = false;
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      ROCKET_LOG = "critical";
    };
  };

  sops.secrets = {
    "vaultwarden/env" = {
      path = "/var/lib/vaultwarden/vaultwarden.env";
      mode = "0400";
      owner = config.users.users.vaultwarden.name;
    };
  };
}
