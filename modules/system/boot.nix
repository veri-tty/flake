{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.loader = {
      grub = {
        enable = true;
        useOSProber = false;
        efiSupport = true;
        enableCryptodisk = true;
        device = "nodev";
        theme = inputs.nixos-grub-themes.packages.${pkgs.system}.nixos;
        backgroundColor = null;
        splashImage = null;
      };
      # Hide the OS choice for bootloaders.
      # It's still possible to open the bootloader list by pressing any key
      # It will just not appear on screen unless a key is pressed
      timeout = 0;
      ## Allow bootloader to alter the UEFI
      efi.canTouchEfiVariables = true;
    };
  };
}
