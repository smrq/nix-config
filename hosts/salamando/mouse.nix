{
  pkgs,
  username,
  ...
}: {
  hardware.openrazer.enable = true;

  users.users.${username}.extraGroups = [ "openrazer" ];
}
