{
  inputs,
  arch,
  ...
}: {
  environment.systemPackages = [
    inputs.azeron-linux.packages.${arch}.default
  ];

  services.udev.extraRules = ''
    # Azeron keypads - HID interface (vendorId 0x16D0 = 5840)
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="16d0", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="16d0", MODE="0666"

    # STM32 DFU bootloader (used during firmware updates)
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0666"
  '';
}
