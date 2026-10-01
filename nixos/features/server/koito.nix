{
  config,
  lib,
  ...
}: {
  services.koito = {
    enable = true;
    environment = {
      KOITO_DEFAULT_USERNAME_FILE = "%d/koito_username";
      KOITO_DEFAULT_PASSWORD_FILE = "%d/koito_password";
    };
  };

  systemd.services.koito.serviceConfig = {
    LoadCredential = [
      "koito_username:${config.sops.secrets."koito/username".path}"
      "koito_password:${config.sops.secrets."koito/password".path}"
    ];
  };

  sops = {
    secrets = {
      "koito/username" = { };
      "koito/password" = { };
    };
  };
}
