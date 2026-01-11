{
  description = "NixOS configuration for smrq";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      vscode-server,
      ...
    }:
    {
      nixosConfigurations = {
        honeyb = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            ./system.nix
            ./hosts/honeyb
            ./users/smrq
            home-manager.nixosModules.home-manager
            vscode-server.nixosModules.default
          ];
        };
      };
    };
}
