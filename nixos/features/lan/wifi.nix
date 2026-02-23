{
  config,
  username,
  ...
}: {
  networking.networkmanager = {
    enable = true;
    ensureProfiles = {
      environmentFiles = [
        config.sops.secrets."wifi/home/ssid".path
        config.sops.secrets."wifi/home/psk".path
      ];

      profiles = {
        "home" = {
          connection = {
            id = "home";
            type = "wifi";
            autoconnect = true;
          };
          wifi = {
            mode = "infrastructure";
            ssid = "$HOME_SSID";
          };
          wifi-security = {
            auth-alg = "open";
            key-mgmt = "wpa-psk";
            psk = "$HOME_PSK";
          };
          ipv4 = {
            method = "auto";
          };
          ipv6 = {
            method = "auto";
            addr-gen-mode = "stable-privacy";
          };
        };
      };
    };
  };

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
    "8.8.8.8"
    "8.8.4.4"
  ];

  sops = {
    secrets = {
      "wifi/home/ssid" = { };
      "wifi/home/psk" = { };
    };
  };

  users.users.${username} = {
    extraGroups = [
      "networkmanager"
    ];
  };
}
 