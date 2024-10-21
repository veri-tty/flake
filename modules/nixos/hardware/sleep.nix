{
  config,
  pkgs,
  lib,
  ...
}:
{

  config = lib.mkIf (config.physical && !config.server) {


    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", DRIVER=="usb", ATTR{power/wakeup}="disabled"
      ACTION=="add", SUBSYSTEM=="i2c", ATTR{power/wakeup}="disabled"
    '';
  };
}
