{
  config,
  lib,
  pkgs,
  ...
}: {
  # Conditionally include LUKS configuration
  boot.initrd.luks.devices = lib.mkIf config.enableLuks {
    cryptroot = {
      device = "/dev/nvme0n1p2";
    };
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
}
