{
  description = "NixOS configuration for smrq";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.11";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
        dryad = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./system.nix
            ./hosts/dryad
            ./users/smrq
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            vscode-server.nixosModules.default
          ];
        };

        honeyb = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./system.nix
            ./hosts/honeyb
            ./users/smrq
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            vscode-server.nixosModules.default
          ];
        };
      };
    };
}
