{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.wm.plasma-6.enable {
  services.desktopManager.plasma6.enable = true;
}
