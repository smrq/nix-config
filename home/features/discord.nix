{
  inputs,
  ...
}: {
  imports = [ inputs.nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;
    discord.vencord.enable = true;
    quickCss = ''
      .winButtons_c38106 {
        display: none;
      }
    '';
    config = {
      useQuickCss = true;
      frameless = true;
    };
  };
}