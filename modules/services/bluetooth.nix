{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.machine.isLaptop {
    ## Enabling bluetooth
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    ## Enabling tray icon
    home-manager.users.${config.user} = {
      services.blueman-applet.enable = true;

      ## Configure blueman windows to be floating
      wayland.windowManager.sway.config.window = {
        commands = lib.mkIf (config.windowmanager == "sway") [
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
