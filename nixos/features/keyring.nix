{
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  environment.extraInit = ''
    if [ -z "$SSH_AUTH_SOCK" -a -n "$XDG_RUNTIME_DIR" ]; then
      export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"
    fi
    ssh-add
  '';
}
