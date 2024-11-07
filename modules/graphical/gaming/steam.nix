{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.steam = lib.mkIf config.gaming.steam.enable {
    enable = true;
  };
}
