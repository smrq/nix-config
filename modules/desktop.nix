{
  username,
  pkgs,
  ...
}: {
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      kitty
    ];

    programs.kitty.enable = true;

    programs.vscode = {
      enable = true;
    };
  };  
}
