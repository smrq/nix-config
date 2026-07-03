{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    usbutils
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/json" = "code-2.desktop";
      "application/x-terminal-emulator" = "kitty.desktop";
      "application/zip" = "dolphin.desktop";
      "image/jpeg" = "qimgv.desktop";
      "image/png" = "qimgv.desktop";
      "image/gif" = "qimgv.desktop";
      "text/x-log" = "code.desktop";
      "x-scheme-handler/discord" = "vesktop.desktop";
      "x-scheme-handler/terminal" = "kitty.desktop";
    };
  };

  # https://discourse.nixos.org/t/dolphin-does-not-have-mime-associations/48985/15
  xdg.configFile."menus/applications.menu".text = ''
    <!DOCTYPE Menu PUBLIC "-//freedesktop//DTD Menu 1.0//EN"
    "http://www.freedesktop.org/standards/menu-spec/1.0/menu.dtd">

    <Menu>
      <Name>Applications</Name>

      <!-- Search the default directories for .desktop files.
          I.e. the /applications subdirectory of each entry in
          $XDG_DATA_DIRS
      -->
      <DefaultAppDirs/>

      <!-- Menus and submenus can use localized names as well as icons
          by referring to a .directory file. This configuration does
          not use them, but add it to the search for future-proofing.
      -->
      <DefaultDirectoryDirs/>

      <!-- Add every .desktop entry in the search result to this
          menu.
      -->
      <Include><All/></Include>

      <!-- List submenus before normal .desktop files in the menu. -->
      <DefaultLayout>
        <Merge type="menus"/>
        <Merge type="files" />
      </DefaultLayout>

      <!-- Applications can add their own menu entries in
          menus/applications-merged/. This will cause them to
          be merged into this menu.
      -->
      <DefaultMergeDirs/>
    </Menu>
  '';
}
