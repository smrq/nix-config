{
  username,
  ...
}:
{
  imports = [
    ../../home/flavors/desktop.nix
  ];

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
  };
}
