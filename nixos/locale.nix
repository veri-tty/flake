{ pkgs, ... }:
  
{
  i18n.defaultLocale = "en_US.UTF8";
  services.xserver.layout = "de";
  console.keyMap = "de";
}
