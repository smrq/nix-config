{
  config,
  inputs,
  ...
}:
let
  secrets-path = builtins.toString inputs.nix-secrets;
in
{
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
