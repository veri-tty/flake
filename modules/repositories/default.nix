{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    repositories = {
      path = lib.mkOption {
        type = lib.types.path;
        description = "Path where the git repositories should be cloned";
        default = "/home/${config.user}/projects";
      };
    };
  };
}
