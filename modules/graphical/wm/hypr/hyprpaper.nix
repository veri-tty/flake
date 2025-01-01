{
  pkgs,
  lib,
  config,
  ...
}: {
  home-manager.users.${config.user} = {
    services.hyprpaper = lib.mkIf config.wm.hyprland.enable {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;
        preload = ["${config.wallpaper}"];
        wallpaper = [
          "eDP-1,${config.wallpaper}"
        ];
      };
    };
  };
}
