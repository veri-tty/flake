{ config, lib, pkgs, ... }:

{
  ## Setting the appropriate option so other modules know it
  options = {
    os = {
      bar = lib.mkOption {
        type = lib.types.path;
        description = "The bar used throughout the system";
      };
    };
  };
  config = {
    os.bar = "${pkgs.waybar}/bin/waybar";
  };
}
