{
  nix-secrets,
  pkgs,
  sops-nix,
  ...
}:
let
  secrets-path = builtins.toString nix-secrets;
in
{
  imports = [
    sops-nix.nixosModules.sops
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
  };
}
