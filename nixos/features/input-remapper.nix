{
  pkgs,
  ...
}:
{
  services.input-remapper = {
    enable = true;
    enableUdevRules = true;
  };

  environment.systemPackages = with pkgs; [
    input-remapper
  ];
}
