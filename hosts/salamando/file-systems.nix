{
  fileSystems."/mnt/win-c" = {
    device = "/dev/nvme0n1p3";
    fsType = "ntfs";
    options = [
      "ro"
      "nofail"
    ];
  };

  fileSystems."/mnt/win-d" = {
    device = "/dev/sda2";
    fsType = "ntfs";
    options = [
      "ro"
      "nofail"
    ];
  };
}
