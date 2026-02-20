{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    bitwarden-cli
    bws
    eza
    fastfetch
    fzf
    nixfmt
  ];
}
