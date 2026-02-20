{
  description = "NixOS configuration for smrq";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-secrets = {
      url = "git+ssh://git@github.com/smrq/nix-secrets.git?shallow=1";
      flake = false;
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-secrets,
      sops-nix,
      vscode-server,
      ...
    }@inputs:
    let
      hosts = import ./config/hosts.nix;

      mkNixOSConfigurations =
        {
          host,
          modules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          system = host.arch;
          specialArgs = {
            inherit inputs;
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
      };

      nixosConfigurations.${hosts.honeyb.hostname} = mkNixOSConfigurations {
        host = hosts.honeyb;
      };
    };
}
