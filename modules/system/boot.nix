{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader = {
    grub = {
      enable = true;
      useOSProber = false;
      efiSupport = true;
      enableCryptodisk = true;
      device = "nodev";
      theme = null;
      backgroundColor = null;
      splashImage = null;
    };

    ## Allow bootloader to alter the UEFI
    efi.canTouchEfiVariables = true;
  };
}
