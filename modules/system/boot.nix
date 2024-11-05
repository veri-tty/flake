{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader = {
    grub = {
      enable = true;
      version = 2;
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
