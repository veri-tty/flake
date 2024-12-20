{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    # Luks-Crypt
    luks = {
      enable = lib.mkEnableOption {
        description = "Enable LUKS encryption";
        default = false;
      };
    };
    # Swap
    swap = {
      enable = lib.mkEnableOption {
        description = "Enable swap";
        default = false;
      };
    };
  };
  config = {
    # Luks-Crypt
    boot.initrd.luks.devices = lib.mkIf config.luks.enable {
      cryptroot = {
        device = "/dev/nvme0n1p2";
        preLVM = true;
        allowDiscards = true;
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

    # Look for swap volume if configured to do so
    swapDevices = lib.mkIf config.swap.enable [
      {device = "/dev/vg0/swap";}
    ];
  };
}
