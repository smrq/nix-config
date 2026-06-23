{
  config,
  ...
}: {
  programs.rclone = {
    enable = true;
    remotes.gdrive = {
      config = {
        type = "drive";
        scope = "drive";
      };
      secrets = {
        client_id = config.sops.secrets."rclone/gdrive/client_id".path;
        client_secret = config.sops.secrets."rclone/gdrive/client_secret".path;
        token = config.sops.secrets."rclone/gdrive/token".path;
      };
      mounts."" = {
        enable = true;
        autoMount = true;
        mountPoint = "${config.home.homeDirectory}/Drive";
      };
    };
  };

  sops.secrets = {
    "rclone/gdrive/client_id" = {};
    "rclone/gdrive/client_secret" = {};
    "rclone/gdrive/token" = {};
  };
}
