{
  config,
  lib,
  pkgs,
  username,
  ...
}: {
  # environment.systemPackages = with pkgs; [
  #   restic
  # ];

  users = {
    users.restic = {
      group = "restic";
      isSystemUser = true;
      home = "/home/restic";
    };
    groups.restic = {};
  };

  security.wrappers.restic = {
    source = lib.getExe pkgs.restic;
    owner = "restic";
    group = "restic";
    permissions = "500";
    capabilities = "cap_dac_read_search=+ep";
  };

  services.restic = {
    backups.honeyb = {
      initialize = true;
      paths = [
        "/var/lib/actual"
        "/var/lib/gonic"
        "/mnt/faerie/Archive"
        "/mnt/faerie/Backups"
        "/mnt/faerie/Music Projects"
        "/mnt/faerie/My Music"
        "/mnt/faerie/Walls"
        "/mnt/faerie/Wedding"
      ];
      exclude = [
        "/var/lib/gonic/cache"
      ];
      checkOpts = [
        "--with-cache"
      ];
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
      ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };
      passwordFile = config.sops.secrets."restic/password".path;
      repository = "sftp:restic-host:/home/restic";
      user = "restic";
      package = pkgs.writeShellScriptBin "restic" ''
        exec /run/wrappers/bin/restic "$@"
      '';
    };
  };

  sops.secrets = {
    "restic/password" = { };
    "restic/ssh_config" = {
      path = "/home/restic/.ssh/config";
      mode = "0400";
      owner = "restic";
    };
    "restic/ssh_key" = {
      key = "ssh_keys/smrq";
      path = "/home/restic/.ssh/id_ed25519";
      mode = "0400";
      owner = "restic";
    };
    "restic/ssh_known_hosts" = {
      path = "/home/restic/.ssh/known_hosts";
      mode = "0600";
      owner = "restic";
    };
  };
}
