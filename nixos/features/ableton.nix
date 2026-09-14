{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.ableton-linux.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  boot.kernelModules = [ "ntsync" ];
}

# Some steps have to be done imperatively.

# Setting up wineprefix
# nix run github:shibco/ableton-linux#setup-prefix

# Installing VSTs into the wine prefix
# ableton-wine path/to/installer.exe

# Install VST2s to: C:\Program Files\Common Files\VST2

# VSTs
# https://www.fabfilter.com/myaccount
# https://accounts.soundtoys.com/#/licenses
# https://www.plugin-alliance.com/pages/my-products
# https://www.toontrack.com/my-products/
# https://www.voxengo.com/product/span/
# https://www.voxengo.com/product/sounddelay/
# https://www.wavesfactory.com/my-purchases/

# Thread on installing iLok License Manager
# https://github.com/shibco/ableton-linux/issues/235#issuecomment-5496875420

# Installing NI Native Access 2:
# Install powershell with winetricks
#   WINE64=ableton-wine winetricks -q powershell_core
#   (TODO: Possibly needs vcrun2022 | ucrtbase2019)
# Alternatively:
#   Install https://github.com/PietJankbal/powershell-wrapper-for-wine
#   WINE64=ableton-wine winetricks -q dotnet48
# Run installer
#   ableton-wine path/to/installer.exe
# Run app with flags
#   ableton-wine "C:\Program Files\Native Instruments\Native Access\Native Access.exe" --disable-gpu
# After logging in, copy the login link and run in a new window
#   "C:\Program Files\Native Instruments\Native Access\Native Access.exe" --disable-gpu -- "native-access://authorize?code=CODE_HERE"

# Installing iZotope Product Portal
# Don't. It doesn't work. Sail the high seas.
