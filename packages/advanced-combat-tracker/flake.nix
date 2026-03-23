{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  
  outputs =
    { ... }:
    {
      hmModules.default = {
        imports = [ ./home.nix ];
      };
    };
}
