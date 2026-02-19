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
    ../../modules/dank.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

  fileSystems."/mnt/faerie" = {
    device = "//manatree/faerie";
    fsType = "cifs";
    options =
      let
        automountOpts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [ "${automountOpts},credentials=${config.sops.templates."smb-secrets-manatree".path}" ];
  };

  networking = {
    hostName = "dryad";
    firewall.allowedTCPPorts = [
      22
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
      "smb/manatree/username" = { };
      "smb/manatree/password" = { };
      "ssh_keys/smrq" = {
        path = "/home/smrq/.ssh/id_ed25519";
        mode = "0400";
        owner = config.users.users.smrq.name;
      };
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
