{
  config,
  lib,
  pkgs,
  ...
}: {
  ## Global options, defined in machnine nix file
  options = {
    # usernames, emails and identities, usually needed on all hosts
    user = lib.mkOption {
      # is defined in flake.nix
      type = lib.types.str;
      description = "Primary user of the system";
      default = "ml";
    };
    fullName = lib.mkOption {
      # is defined in flake.nix
      type = lib.types.str;
      description = "github username";
    };
    mail = {
      git = lib.mkOption {
        # is defined in flake.nix
        type = lib.types.str;
        description = "email for github";
      };
    };
    keyboard = {
      layout = lib.mkOption {
        type = lib.types.str;
        description = "Primary keyboard layout";
        default = "de";
      };
    };

    #
    #
    # system specific settings
    luks = {
      enable = lib.mkEnableOption {
        description = "Enable LUKS encryption";
        default = false;
      };
    };

    swap = {
      enable = lib.mkEnableOption {
        description = "Swapfile?";
        default = false;
      };
    };

    machine = {
      isLaptop = lib.mkOption {
        type = lib.types.bool;
        description = "Whether the machine is a laptop";
        default = false;
      };
    };
    stateVers = lib.mkOption {
      # is defined in flake.nix
      type = lib.types.str;
      description = "State version of nixos and home-manager";
    };
    gui = {
      enable = lib.mkEnableOption {
        description = "Enable graphics.";
        default = false;
      };
    };
    wayland = {
      enable = lib.mkEnableOption {
        description = "Wayland or not.";
        default = false;
      };
    };
    nvidia = {
      enable = lib.mkEnableOption {
        description = "Nvidia or not.";
        default = false;
      };
    };
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
    shell = lib.mkOption {
      type = lib.types.string;
      description = "Shell to use";
      default = "zsh";
    };

    pgp = {
      enable = lib.mkEnableOption {
        description = "Enable PGP, Gnupgp and all that shabang";
        default = false;
      };
    };

    terminal = lib.mkOption {
      type = lib.types.str;
      description = "Default terminal emulator";
      default = "kitty";
    };

    thunderbird = {
      enable = lib.mkEnableOption {
        description = "Enable Thunderbird";
        default = false;
      };
    };
    firefox = {
      enable = lib.mkEnableOption {
        description = "Enable Firefox";
        default = false;
      };
    };
    schizofox = {
      enable = lib.mkEnableOption {
        description = "Enable Schizofox";
        default = false;
      };
    };
    syncthing = {
      enable = lib.mkEnableOption {
        description = "Enable Syncthing Service";
        default = false;
      };
    };
    mullvad = {
      enable = lib.mkEnableOption {
        description = "Enable Mullvad VPN";
        default = false;
      };
    };
    tailscale = {
      enable = lib.mkEnableOption {
        description = "Enable Tailscale VPN";
        default = false;
      };
    };
    docker = {
      enable = lib.mkEnableOption {
        description = "Enable Docker";
        default = false;
      };
    };

    # # well gaming related stuffs duh
    # gaming = {
    #   int-fic = {
    #     enable = lib.mkEnableOption {
    #       description = "Whether to enable the Gargoyle Interactive Fiction Interpreter";
    #       default = false;
    #     };
    #   };
    #   wine = {
    #     enable = lib.mkEnableOption {
    #       description = "Whether to enable the Wine compatibility layer";
    #       default = false;
    #     };
    #   };
    #   steam = {
    #     enable = lib.mkEnableOption {
    #       description = "Whether to enable Steam";
    #       default = false;
    #     };
    #   };
    # };
  };
  ## Global configuration
  ## Should only contain global settings that are not related to
  ## any particular part of the system and could therefore be
  ## extracted into their own module.
  config = {
    nix = {
      ## Enabling flakes
      extraOptions = ''
        experimental-features = nix-command flakes
        warn-dirty = false
      '';

      ## Store optimization
      optimise.automatic = true;

      ## Automatic garbage collection
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };

    ## Timezone and locales
    ## I don't travel
    time.timeZone = "Europe/Berlin";
    i18n.defaultLocale = "en_US.UTF-8";

    home-manager.backupFileExtension = "delme";
    ## Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    ## Setting correct application settings if we're running wayland
    environment.sessionVariables = lib.mkIf config.wayland.enable {
      NIXOS_OZONE_WL = "1";
    };

    ## Global packages
    ## Packages should be managed with home-manager whereever
    ## possible. Only use a set of barebones applications here.
    environment.systemPackages = with pkgs; [git vim unzip wget curl ripgrep];

    ## Home manager settings
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    ## Setting the `stateVersion' for both home-manager and system.
    home-manager.users.${config.user}.home.stateVersion = "${config.stateVers}";
    ## Setting state version for system
    system.stateVersion = "${config.stateVers}";
  };
  imports = [
    ./graphical/gaming
    ./graphical/wm
    ./graphical/editors
    ./graphical/terminal.nix
    ./graphical/thunderbird.nix
    ./graphical/browsers/firefox.nix
    ./graphical/browsers/schizofox.nix
    ./services/bluetooth.nix
    ./services/docker.nix
    ./services/pipewire.nix
    ./services/syncthing.nix
    ./services/vpn.nix
    ./services/git.nix
    ./services/pgp.nix
    ./services/xdg.nix
    ./shell/zsh.nix
    ./system/boot.nix
    ./system/filesystem.nix
    ./system/font.nix
    ./system/networking.nix
    ./system/nvidia.nix
    ./system/backlight.nix
  ];
}
