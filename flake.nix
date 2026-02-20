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
    {
      nixosConfigurations = {
        dryad =
          let
            hostname = "dryad";
            username = "smrq";
          in
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs hostname username;
            };
            modules = [
              ./system.nix
              ./hosts/${hostname}
              ./users/${username}
              ./modules/desktop.nix
              ./modules/dms.nix
              ./modules/lan.nix
              ./modules/openssh.nix
              ./modules/vscode-server.nix
              home-manager.nixosModules.home-manager
            ];
          };

        honeyb =
          let
            hostname = "honeyb";
            username = "smrq";
          in
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs hostname username;
            };
            modules = [
              ./system.nix
              ./hosts/${hostname}
              ./users/${username}
              ./modules/lan.nix
              ./modules/openssh.nix
              ./modules/ssh-agent.nix
              ./modules/vscode-server.nix
              home-manager.nixosModules.home-manager
            ];
          };
      };
    };
}
