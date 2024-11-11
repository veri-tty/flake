{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    wallpaper = lib.mkOption {
      type = lib.types.str;
      description = "should be somewhat obvious you airhead";
    };
    theme = {
      colors = lib.mkOption {
        type = lib.types.attrs;
        description = "Base16 color scheme.";
        default = import ../themes/catppuccin-macchiato.nix;
      };
    };
    gtk.theme = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "Theme name for GTK applications";
      };
      package = lib.mkOption {
        type = lib.types.package;
        description = "Theme package for GTK applications";
        default = pkgs.magnetic-catppuccin-gtk;
      };
    };
    font = {
      size = lib.mkOption {
        type = lib.types.int;
        default = 16;
      };
      mono = lib.mkOption {
        type = lib.types.str;
        description = "Default monospaced font";
        default = "VictorMono";
      };
    };
  };
  config = {
    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = ["Victor Mono"];
        };
      };
      packages = with pkgs; [
        victor-mono
        noto-fonts-emoji
      ];
    };
    home-manager.users.${config.user} = {
      gtk = let
        gtkExtraConfig = {
          gtk-application-prefer-dark-theme = "true";
        };
      in {
        enable = true;
        theme = {
          name = "${config.gtk.theme.name}";
          package = "${config.gtk.theme.package}";
        };
        gtk3.extraConfig = gtkExtraConfig;
        gtk4.extraConfig = gtkExtraConfig;
      };
    };

    # Required for setting GTK theme (for preferred-color-scheme in browser)
    services.dbus.packages = [pkgs.dconf];
    programs.dconf.enable = true;

    environment.sessionVariables = {
      GTK_THEME = config.gtk.theme.name;
    };
  };
}
