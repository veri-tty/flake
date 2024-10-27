{ config, lib, pkgs, ... }:

{
  ## Setting the appropriate option so other modules know it
  options = {
    os = {
      launcher = {
        pkg = lib.mkOption {
          type = lib.types.path;
          description = "The launcher in use";
        };

        name = lib.mkOption {
          type = lib.types.str;
          description = "Name of the launcher used";
        };
        
        configFile = lib.mkOption {
          type = lib.types.path;
          description = "Config file of the current launcher";
        }; 

        args = lib.mkOption {
          type = lib.types.str;
          description = "Additional args for the launcher";
        };
      };
    };
  };
}
