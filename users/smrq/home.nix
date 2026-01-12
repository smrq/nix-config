{
  pkgs,
  ...
}:
let
  vscode-server-tarball = fetchTarball {
    url = "https://github.com/nix-community/nixos-vscode-server/tarball/6d5f074e4811d143d44169ba4af09b20ddb6937d";
    sha256 = "1rdn70jrg5mxmkkrpy2xk8lydmlc707sk0zb35426v1yxxka10by";
  };
in
{
  imports = [ "${vscode-server-tarball}/modules/vscode-server/home.nix" ];

  home = {
    username = "smrq";
    homeDirectory = "/home/smrq";
    stateVersion = "25.11";
    packages = with pkgs; [
      bitwarden-cli
      bws
      eza
      fastfetch
      fzf
      nixfmt-rfc-style
    ];
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;

      settings.user.email = "smrq@smrq.net";
      settings.user.name = "Greg Smith";
      #settings.commit.gpgsign = true;
      #settings.gpg.format = "ssh";
      #settings.user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN3ORdArlT3Dya0q/lgJ4pnrN84oeglS9D7omApOGtMX";

      settings.init.defaultBranch = "main";
      settings.alias = {
        amend = "commit --amend --no-edit";
        l = "log --oneline --graph --decorate --all";
      };
    };
  };

  services = {
    vscode-server.enable = true;
  };
}
