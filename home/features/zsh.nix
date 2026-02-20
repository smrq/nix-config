{
  hostname,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza --group-directories-first";
      ll = "eza --group-directories-first -la";
      nixup = "nixos-rebuild switch --sudo --flake .#${hostname}";
      nixgc = "nix-collect-garbage -d";
    };
    history.size = 10000;
  };
}
