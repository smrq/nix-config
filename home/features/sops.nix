{
  config,
  inputs,
  ...
}:
let
  secrets-path = builtins.toString inputs.nix-secrets;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    defaultSopsFile = "${secrets-path}/secrets.yaml";
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };
}
