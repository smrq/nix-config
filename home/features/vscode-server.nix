let
  vscode-server-tarball = fetchTarball {
    url = "https://github.com/nix-community/nixos-vscode-server/tarball/6d5f074e4811d143d44169ba4af09b20ddb6937d";
    sha256 = "1rdn70jrg5mxmkkrpy2xk8lydmlc707sk0zb35426v1yxxka10by";
  };
in
{
  imports = [
    "${vscode-server-tarball}/modules/vscode-server/home.nix"
  ];

  services.vscode-server.enable = true;
}
