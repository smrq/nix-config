{
  imports = [
    ../../modules/sops.nix
  ];

  users.users.smrq = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN3ORdArlT3Dya0q/lgJ4pnrN84oeglS9D7omApOGtMX"
    ];
  };

  security.sudo.extraRules = [
    {
      users = [ "smrq" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  sops.secrets = {
    "ssh_keys/smrq" = {
      path = "/home/smrq/.ssh/id_ed25519";
      mode = "0400";
      owner = "smrq";
    };
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.smrq = import ./home.nix;
}
