{
  config,
  lib,
  pkgs,
  ...
}: {
  lib.mkIf config.enableLuks {
    # Luks-Crypt
    boot.initrd.luks.devices."cryptroot".device = "/dev/nvme0n1p2";
  };
  
  # Main partition
  fileSystems."/" = {
    device = "/dev/vg0/root";
    fsType = "ext4";
  };

  # Boot partition
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  # Look for swap volume if configured to do so
  lib.mkIf config.enableSwap {
    swapDevices = [
      { device = "/dev/vg0/swap"; }
    ];
  };
}
