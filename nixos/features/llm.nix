{
  inputs,
  pkgs,
  ...
}: let
  opencode = inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system}.default;
  llama-cpp = pkgs.llama-cpp.override { cudaSupport = true; };
in {
  environment.systemPackages = [
    opencode
    llama-cpp
  ];
}
