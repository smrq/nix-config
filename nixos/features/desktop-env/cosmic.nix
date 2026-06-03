{
  username,
  ...
}: {
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = username;
  };

  services.system76-scheduler.enable = true;
}
