{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    docker = {
      enable = lib.mkEnableOption {
        description = "Enable Docker Service";
        default = false;
      };
    };
  };
  config = {
    virtualisation.docker = lib.mkIf config.docker.enable {
      enable = true;
    };
  };
}
