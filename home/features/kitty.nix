{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration.enableZshIntegration = true;
    extraConfig = ''
      # BEGIN_KITTY_FONTS
      font_family      family='Iosevka' postscript_name=Iosevka
      bold_font        auto
      italic_font      auto
      bold_italic_font auto
      # END_KITTY_FONTS

      font_size 10.0

      cursor_shape beam
      cursor_trail 1
      cursor_trail_decay 0.1 0.25

      tab_bar_style powerline
      tab_powerline_style slanted

      enable_audio_bell no
      visual_bell_duration 0.25
    '';
  };
}