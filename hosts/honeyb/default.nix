{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "honeyb";
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

    openssh.enable = true;
  };
}
