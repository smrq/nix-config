{
  username,
  ...
}:
{
  imports = [
    ../../home/flavors/server.nix
  ];

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
  };
}
