{
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        ms-vscode-remote.remote-ssh
      ];
      userSettings = {
        "editor.fontFamily" = "'Iosevka', monospace";
      };
    };
  };
}
