{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  
  outputs =
    { ... }:
    {
      nixosModules.default = {
        imports = [ ./nixos.nix ];
      };
    };
}
