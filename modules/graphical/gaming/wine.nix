{
  pkgs,
  config,
  lib,
  ...
}: {
  environment.systemPackages = lib.mkIf config.gaming.wine.enable [
    pkgs.wineWowPackages.waylandFull
  ];
}
