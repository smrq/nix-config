{
  description = "NixOS configuration for smrq";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-secrets = {
      url = "git+ssh://git@github.com/smrq/nix-secrets.git?shallow=1";
      flake = false;
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
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
      ...
    }@inputs:
    let
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
                inherit inputs;
                hostname = host.hostname;
                username = host.username;
              };
              home-manager.users."${host.username}" = import ./hosts/${host.hostname}/home.nix;
            }
          ] ++ modules;
        };

    in {
      nixosConfigurations.dryad = mkNixOSConfigurations {
        host = {
          hostname = "dryad";
          username = "smrq";
          arch = "x86_64-linux";
        };
      };

      nixosConfigurations.honeyb = mkNixOSConfigurations {
        host = {
          hostname = "honeyb";
          username = "smrq";
          arch = "x86_64-linux";
        };
      };
    };
}
