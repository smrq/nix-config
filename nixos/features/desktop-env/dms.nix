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
    ssh-add
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
  
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
}
