{
  pkgs,
  config,
  lib,
  ...
}: {
  environment.systemPackages = lib.mkIf config.gaming.int-fic.enable [
    pkgs.gargoyle
  ];
}
