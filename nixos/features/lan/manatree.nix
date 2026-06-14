{
  config,
  lib,
  pkgs,
  username,
  ...
}: {
  imports = [
    ../sops.nix
  ];
  
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

  fileSystems."/mnt/faerie" = {
    device = "//manatree/faerie";
    fsType = "cifs";
    options = [
      "x-systemd.automount"
      "noauto"
      "nounix"
      "nobrl"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
      "uid=${builtins.toString config.users.users.${username}.uid}"
      "rw"
      "credentials=${config.sops.templates."smb-secrets-manatree".path}"
    ];
  };

  services.samba.enable = true;

  sops = {
    secrets = {
      "smb/manatree/username" = { };
      "smb/manatree/password" = { };
    };
    templates = {
      "smb-secrets-manatree" = {
        content = ''
          username=${config.sops.placeholder."smb/manatree/username"}
          password=${config.sops.placeholder."smb/manatree/password"}
        '';
      };
    };
  };
}
