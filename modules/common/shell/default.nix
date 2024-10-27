{ config, lib, pkgs, ... }:

{
  ## Setting the appropriate option so other modules know it
  options = {
    os = {
      shell = lib.mkOption {
        type = lib.types.str;
        default = "zsh";
        description = "Shell used on the system";
      };
    };
  };
  config = {
    environment.systemPackages = [
      pkgs.ripgrep
    ];
  };
}
