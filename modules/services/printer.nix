{
  config,
  lib,
  pkgs,
  ...
}: {
  services = {
    printing.enable = true;
    avahi.enable = true;
    avahi.nssmdns4 = true;
    # for a WiFi printer
    avahi.openFirewall = false;
  };
}
