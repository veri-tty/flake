{
  config,
  lib,
  pkgs,
  ...
}: {
  config = let
    ## Using the correct package based on the window system
    rofiPkg =
      if config.wayland.enable
      then pkgs.rofi-wayland
      else pkgs.rofi;
  in {
    ## Configuration
    home-manager.users.${config.user} = {
      programs.rofi = {
        enable = true;
        package = rofiPkg;
        theme = "dmenu";
        font = "VictorMono ${builtins.toString config.font.size}";

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
