{ config, lib, pkgs, ... }:

{
  config = {
    ## Binding media keys
    home-manager.users.${config.user}.services = {
      wlsunset = lib.mkIf config.os.wayland {
        enable = true;
        latitude = "49.8";
        longitude = "8.6";
      };
    };
  };
}

