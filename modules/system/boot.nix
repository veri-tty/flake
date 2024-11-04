{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader = {
    grub = {
      ## Use Grub as the bootloader
      enable = true;
      devices = ["/dev/disk/by-label/boot"];

      configurationName = "NixOS";

      ## Enable EFI support
      efiSupport = true;
    };

    ## Allow bootloader to alter the UEFI
    efi.canTouchEfiVariables = true;
  };
}
