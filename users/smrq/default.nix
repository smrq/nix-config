{
  hostname,
  username,
  pkgs,
  ...
}:
let
  public-key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN3ORdArlT3Dya0q/lgJ4pnrN84oeglS9D7omApOGtMX";
in
{
  imports = [
    ../../modules/sops.nix
  ];

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [ public-key ];
  };

  security.sudo.extraRules = [
    {
      users = [ username ];
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
      path = "/home/${username}/.ssh/id_ed25519";
      mode = "0400";
      owner = username;
    };
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${username} = {
    home = {
      username = username;
      homeDirectory = "/home/${username}";
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
        settings.commit.gpgsign = true;
        settings.gpg.format = "ssh";
        settings.user.signingkey = public-key;

        settings.init.defaultBranch = "main";
        settings.push.autoSetupRemote = true;
        settings.alias = {
          amend = "commit --amend --no-edit";
          l = "log --oneline --graph --decorate --all";
        };
      };

      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        shellAliases = {
          ll = "ls -la";
          nixup = "nixos-rebuild switch --sudo --flake .#${hostname}";
          nixgc = "nix-collect-garbage -d";
        };
        history.size = 10000;
      };
    };
  };
}
