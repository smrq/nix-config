{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    pkgs.reaper
  ];
  security.rtkit.enable = true;
  services.pipewire = {
    jack.enable = true;
  };
}
