{
  description = "NixOS configuration for smrq";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    sops-nix-stable = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  
    nix-secrets = {
      url = "git+ssh://git@github.com/smrq/nix-secrets.git?shallow=1";
      flake = false;
    };

    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs =
    {
      nix-secrets,
      vscode-server,
      ...
    }@inputs:
    let
      hosts = import ./config/hosts.nix;

      mkNixOSConfigurations =
        {
          host,
          nixpkgs,
          home-manager,
          sops-nix,
          modules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          system = host.arch;
          specialArgs = {
            inherit nix-secrets;
            inherit sops-nix;
            inherit vscode-server;
            hostname = host.hostname;
            username = host.username;
          };
          modules = [
            ./hosts/${host.hostname}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                hostname = host.hostname;
                username = host.username;
              };
              home-manager.users."${host.username}" = import ./hosts/${host.hostname}/home.nix;
            }
          ] ++ modules;
        };

    in {
      nixosConfigurations.${hosts.dryad.hostname} = mkNixOSConfigurations {
        host = hosts.dryad;
        nixpkgs = inputs.nixpkgs;
        home-manager = inputs.home-manager;
        sops-nix = inputs.sops-nix;
      };

      nixosConfigurations.${hosts.honeyb.hostname} = mkNixOSConfigurations {
        host = hosts.honeyb;
        nixpkgs = inputs.nixpkgs-stable;
        home-manager = inputs.home-manager-stable;
        sops-nix = inputs.sops-nix-stable;
      };
    };
}
