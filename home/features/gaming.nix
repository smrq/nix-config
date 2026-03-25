{
  # https://www.reddit.com/r/linux_gaming/comments/1mg8vtl/low_latency_gaming_guide/
  home.sessionVariables = {
    MESA_VK_WSI_PRESENT_MODE = "immediate";
    ENABLE_LAYER_MESA_ANTI_LAG = 1;
    
    KWIN_DRM_NO_AMS = 1;
    PROTON_USE_NTSYNC = 1;
    PROTON_ENABLE_WAYLAND = 1;
    SDL_VIDEODRIVER = "wayland";
  };
}