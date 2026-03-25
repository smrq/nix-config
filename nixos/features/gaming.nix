{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    xivlauncher
  ];

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  # System parameters from:
  # https://github.com/keenanweaver/nix-config/blob/148ce0e8642cf9956b64e73c50c157815af9cd07/modules/profiles/gaming/default.nix

  boot.kernelParams = [
    "clocksource=tsc"
    "tsc=reliable"
    "preempt=full"
    "gpu_sched.sched_policy=0"
  ];

  boot.kernel.sysctl = {
    # https://github.com/CachyOS/CachyOS-Settings/blob/master/usr/lib/sysctl.d/70-cachyos-settings.conf

    # The value controls the tendency of the kernel to reclaim the memory which is used for caching of directory and inode objects (VFS cache).
    # Lowering it from the default value of 100 makes the kernel less inclined to reclaim VFS cache (do not set it to 0, this may produce out-of-memory conditions)
    "vm.vfs_cache_pressure" = 50;

    # Contains, as bytes, the number of pages at which a process which is
    # generating disk writes will itself start writing out dirty data.
    "vm.dirty_bytes" = 268435456;

    # Contains, as bytes, the number of pages at which the background kernel
    # flusher threads will start writing out dirty data.
    "vm.dirty_background_bytes" = 67108864;

    # The kernel flusher threads will periodically wake up and write old data out to disk.  This
    # tunable expresses the interval between those wakeups, in 100'ths of a second (Default is 500).
    "vm.dirty_writeback_centisecs" = 1500;

    # This action will speed up your boot and shutdown, because one less module is loaded. Additionally disabling watchdog timers increases performance and lowers power consumption
    # Disable NMI watchdog
    "kernel.nmi_watchdog" = 0;

    # Increase netdev receive queue
    # May help prevent losing packets
    "net.core.netdev_max_backlog" = 4096;

    # Set size of file handles and inode cache
    "fs.file-max" = 2097152;
  };

  # https://github.com/CachyOS/CachyOS-Settings/blob/master/usr/lib/systemd/system.conf.d/10-limits.conf
  systemd.settings.Manager = {
    DefaultLimitNOFILE = "2048:2097152";
  };
}