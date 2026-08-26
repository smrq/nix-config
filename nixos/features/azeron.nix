{
  pkgs,
  lib,
  ...
}: let
  azeron-app = let
    version = "2.0.2";
  in pkgs.appimageTools.wrapType2 {
    pname = "azeron";
    inherit version;
    src = pkgs.fetchurl {
      url = "https://azeron-software-public.s3.us-east-1.amazonaws.com/live/${version}/Azeron-Software-v${version}.AppImage";
      hash = "sha256-D9d5Og3uIKmCs3Tw9hRozbjJ8oAhBR+Vv0oRWchoHh4=";
    };

    extraBwrapArgs = [
      "--dev-bind /dev /dev"
      "--bind /run/udev /run/udev"
    ];

    meta = {
      description = "Azeron Software";
      license = lib.licenses.unfree;
      homepage = "https://azeron.com";
      downloadPage = "https://azeron.com/pages/software";
      sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
      platforms = [ "x86_64-linux" ];
    };
  };

  azeron-desktop = pkgs.makeDesktopItem {
    name = "azeron";
    exec = "azeron";
    icon = "azeron";
    desktopName = "Azeron Software";
    genericName = "Keypad Configuration";
    categories = ["Utility"];
  };

  azeron-combined = pkgs.symlinkJoin {
    name = "azeron-combined";
    paths = [azeron-app azeron-desktop];
  };
in {
  boot.kernelModules = [ "xpad" ];

  environment.systemPackages = [ azeron-combined ];

  services.udev.extraRules = ''
    # Azeron keypads - HID interface (vendorId 0x16D0 = 5840)
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="16d0", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="16d0", MODE="0666"

    # STM32 DFU bootloader (used during firmware updates)
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0666"

    # xpad
    ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="12f7", RUN+="/sbin/modprobe xpad", RUN+="/bin/sh -c 'echo 16d0 12f7 > /sys/bus/usb/drivers/xpad/new_id'"
  '';
}
