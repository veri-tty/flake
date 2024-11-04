{
  config,
  pkgs,
  lib,
  ...
}: {
  virtualisation.docker = lib.mkIf config.docker.enable {
    enable = true;
  };
}
