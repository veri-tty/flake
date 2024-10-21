{
  config,
  pkgs,
  lib,
  ...
}:
{

  options = {
    syncthing = {
      enable = lib.mkEnableOption {
        description = "Enable syncthing.";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.gui.enable && config.syncthing.enable) {

    home-manager.users.${config.user} = {

      home.packages = with pkgs; [ syncthing ];
    };
  };
}
