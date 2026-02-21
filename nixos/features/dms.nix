{
  inputs,
  username,
  pkgs,
  ...
}: {
  imports = [
    inputs.dms-plugin-registry.modules.default
  ];

  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];

  environment.extraInit = ''
    if [ -z "$SSH_AUTH_SOCK" -a -n "$XDG_RUNTIME_DIR" ]; then
      export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"
    fi
  '';

  programs.dms-shell = {
    enable = true;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    enableSystemMonitoring = true;
  };

  programs.dsearch.enable = true;

  programs.niri.enable = true;

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${username}";
  };
}
