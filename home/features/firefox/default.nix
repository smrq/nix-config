{
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        isDefault = true;
        userChrome = (builtins.readFile ./userChrome.css);
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
      };
    };
  };
}
