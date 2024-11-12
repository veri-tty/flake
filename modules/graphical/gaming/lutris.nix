{
  pkgs,
  config,
  lib,
  ...
}: {
  environment.systemPackages = lib.mkIf config.gaming.lutris.enable [
    pkgs.lutris
  ];
}
