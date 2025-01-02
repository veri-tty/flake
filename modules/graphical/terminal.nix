{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    home-manager.users.${config.user} = {
      programs.kitty = lib.mkIf (config.terminal == "kitty") {
        enable = true;
        environment = {};
        extraConfig = "";
        font.size = 15;
        font.name = "${config.font.mono}";
        themeFile = "Solarized_Dark_Higher_Contrast";
        settings = {
          background_opacity = 0.95;
          # Scrollback
          scrollback_lines = 10000;
          scrollback_pager_history_size = 300; # MB

          # Window
          window_padding_width = 8;
          window_border_width = 8;
          draw_minimal_borders = "yes";
          hide_window_decorations = "yes";
          tab_bar_style = "custom";

          # Disable audio
          enable_audio_bell = false;
        };
      };
    };
  };
}
