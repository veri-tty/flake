{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    kitty = {
      enable = lib.mkEnableOption {
        description = "Enable Kitty.";
        default = false;
      };
    };
    config = {
      os.terminal = "${pkgs.kitty}/bin/kitty";
    };
  };

  config = {
    # Set the Rofi-Systemd terminal for viewing logs
    # Using optionalAttrs because only available in NixOS
    environment =
      {}
      // lib.attrsets.optionalAttrs (builtins.hasAttr "sessionVariables" config.environment) {
        sessionVariables.ROFI_SYSTEMD_TERM = lib.mkDefault "${pkgs.kitty}/bin/kitty";
      };

    home-manager.users.${config.user} = {
      # Set the Rofi terminal for running programs
      programs.rofi.terminal = lib.mkIf pkgs.stdenv.isLinux (lib.mkDefault "${pkgs.kitty}/bin/kitty");

      # Display images in the terminal
      #programs.fish.interactiveShellInit = # fish
      #  ''
      #    if test "$TERM" = "xterm-kitty"
      #        alias icat="kitty +kitten icat"
      #        alias ssh="kitty +kitten ssh"
      #    end
      #  '';

      programs.kitty = {
        enable = true;
        environment = {};
        extraConfig = "";
        font.size = 15;
        font.name = config.os.fonts.mono.regular;
        theme = "Catppuccin-Macchiato";
        keybindings = {
          # Use shift+enter to complete text suggestions in fish
          "shift+enter" = "send_text all \\x1F";

          # Easy fullscreen toggle (for macOS)
          "super+f" = "toggle_fullscreen";
        };
        settings = {
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
