{
  config,
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
      nixup = "nixos-rebuild switch --sudo --flake ${config.home.homeDirectory}/git/nix-config#${hostname}";
      nixboot = "nixos-rebuild boot --sudo --flake ${config.home.homeDirectory}/git/nix-config#${hostname}";
      nixgc = "nix-collect-garbage -d";
    };
    initContent = ''
      pskill() {
        local pid=$(ps aux | grep -v grep | grep "$1" | awk '{print $2}' | head -n 1)
        if [[ -n "$pid" ]]; then
          kill $pid
        else
          echo "No process found matching '$1'."
          return 1
        fi
      }

      nixremote() {
        nixos-rebuild switch --sudo --flake ${config.home.homeDirectory}/git/nix-config#$1 --target-host $1.local
      }
    '';
    history.size = 10000;
  };
}
