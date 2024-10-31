{
  config,
  lib,
  pkgs,
  ...
}: {
  ## Setting the appropriate option so other modules know it
  options = {
    os = {
      file-manager = lib.mkOption {
        type = lib.types.str;
        description = "File manager used throughout the system";
      };
    };
  };
}
