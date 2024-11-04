{ config, lib, pkgs, ... }:

{
  config = {

    ## Enabling bluetooth
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    ## Enabling tray icon
    home-manager.users.${config.user} = {
      services.blueman-applet.enable = true;

      ## Configure blueman windows to be floating
      wayland.windowManager.sway.config.window = {
        commands = lib.mkIf (config.os.wm == "sway") [
          {
            command = "floating enable, border pixel 2";
            criteria = {
              app_id = "\.blueman.*";
            };
          }
        ];
      };
    };
  };
}

