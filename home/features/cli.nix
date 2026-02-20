{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    bitwarden-cli
    bws
    eza
    fzf
    nixfmt
  ];
}
