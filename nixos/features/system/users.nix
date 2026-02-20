{
  username,
  ...
}:
let
  public-key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN3ORdArlT3Dya0q/lgJ4pnrN84oeglS9D7omApOGtMX";
in
{
  imports = [
    ../sops.nix
  ];

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [ public-key ];
  };

  security.sudo.wheelNeedsPassword = false;

  sops.secrets = {
    "ssh_keys/smrq" = {
      path = "/home/${username}/.ssh/id_ed25519";
      mode = "0400";
      owner = username;
    };
  };
}
