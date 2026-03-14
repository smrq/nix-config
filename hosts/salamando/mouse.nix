{
  pkgs,
  username,
  ...
}: {
  hardware.openrazer.enable = true;
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    polychromatic
  ];
  users.users.${username}.extraGroups = [ "openrazer" ];
}
