{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.plasma-6.enable {
  services.desktopManager.plasma6.enable = true;
}
