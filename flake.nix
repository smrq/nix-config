{
  description = "NixOS configuration for smrq";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    azeron-linux = {
      url = "./packages/azeron-linux";
      inputs.nixpkgs.follows = "nixpkgs";
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
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xpad = {
      url = "./packages/xpad";
      inputs.nixpkgs.follows = "nixpkgs";
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
            inherit (host) arch hostname username;
          };
          modules = [
            ./hosts/${host.hostname}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit (host) arch hostname username;
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

      nixosConfigurations.salamando = mkNixOSConfigurations {
        host = {
          hostname = "salamando";
          username = "smrq";
          arch = "x86_64-linux";
        };
      };
    };
}
