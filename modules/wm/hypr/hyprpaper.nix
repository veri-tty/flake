{
  pkgs,
  lib,
  config,
  ...
}: {
  home-manager.users.${config.user} = {
    services.hyprpaper.enable = true;
    services.hyprpaper.settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = ["${config.wallpaper}"];
      wallpaper = [
        "DP-1,${config.wallpaper}"
      ];
    };
  };
}
