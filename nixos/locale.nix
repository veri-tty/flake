{ pkgs, ... }:
  
{
  i18n.defaultLocale = "en_US.UTF8";
  services.xserver.xkb.layout = "de";
  console.keyMap = "de";
  time.timeZone = "Europe/Berlin";
}
