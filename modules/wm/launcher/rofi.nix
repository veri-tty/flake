{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../launcher
  ];

  config = let
    ## Using the correct package based on the window system
    rofiPkg =
      if config.wayland
      then pkgs.rofi-wayland
      else pkgs.rofi;
  in {
    ## Telling the config about the launcher
    os.launcher.pkg = rofiPkg;
    os.launcher.name = "rofi";
    os.launcher.args = "-show drun";
    os.launcher.configFile = config.home-manager.users.${config.user}.programs.rofi.configPath;

    ## Configuration
    home-manager.users.${config.user} = {
      programs.rofi = {
        enable = true;
        package = rofiPkg;
        theme = "dmenu";
        font = "${config.os.fonts.mono.light} ${builtins.toString config.os.fonts.size}";

        extraConfig = {
          show-actions = true;
          show-icons = true;

          ## Keybindingst
          kb-element-next = "";
          kb-row-select = "Tab,Control+i";
          kb-secondary-paste = "Control+y";
          kb-remove-word-forward = "Alt+d";
          kb-remove-word-backward = "Control+w,Control+Backspace";
          kb-clear-line = "Control+slash";
          kb-page-next = "Control+v";
          kb-page-prev = "Alt+v";
        };
      };
    };
  };
}
