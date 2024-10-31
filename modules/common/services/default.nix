{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    ## ACPI
    services.acpid.enable = true;
    services.acpid.logEvents = true;

    ## DBus
    services.dbus.enable = true;
    services.upower.enable = true;
  };
}
