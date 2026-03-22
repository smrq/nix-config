{
  inputs,
  arch,
  ...
}: {
  imports = [
    inputs.xpad.nixosModules.xpad
  ];

  environment.systemPackages = [
    inputs.azeron-linux.packages.${arch}.default
  ];

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
