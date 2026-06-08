{
  inputs,
  pkgs,
  username,
  ...
}:
let
  secrets-path = builtins.toString inputs.nix-secrets;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    sops
    ssh-to-age
  ];

  sops = {
    defaultSopsFile = "${secrets-path}/secrets.yaml";
    defaultSopsFormat = "yaml";
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    secrets = {
      "sops/ssh_key" = {
        key = "ssh_keys/smrq/age";
        path = "/home/${username}/.config/sops/age/keys.txt";
        mode = "0400";
        owner = username;
      };
    };
  };
}
