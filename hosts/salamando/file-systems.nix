{
  fileSystems."/mnt/win-c" = {
    device = "/dev/disk/by-uuid/E2B2E4F9B2E4D359";
    fsType = "ntfs";
    options = [
      "ro"
      "nofail"
    ];
  };

  fileSystems."/mnt/win-d" = {
    device = "/dev/disk/by-uuid/6042859D42857914";
    fsType = "ntfs";
    options = [
      "ro"
      "nofail"
    ];
  };
}
