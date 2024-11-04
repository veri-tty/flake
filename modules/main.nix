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
      description = "Full name of the user";
    };

    # system specific settings
    keyboard = {
      layout = lib.mkOption {
        type = lib.types.str;
        description = "Primary keyboard layout";
        default = "de";
      };
    };
    luks = {
      enable = lib.mkEnableOption {
        description = "Enable LUKS encryption";
        default = false;
      };
    };

    swap = lib.mkEnableOption {
      enable = lib.mkEnableOption {
        description = "Enable swap";
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

    # window manager and theming related stuffs
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
    windowmanager = lib.mkOption {
      type = lib.types.str;
      description = "Window manager to use";
      default = "sway";
    };
    wallpaper = lib.mkOption {
      type = lib.types.str;
      description = "should be somewhat obvious you airhead";
    };
    theme = lib.mkOption {
      type = lib.types.string;
      description = "Base16 color scheme.";
      default = "catppuccin-macchiato";
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
    font = lib.mkOption {
      type = lib.types.string;
      description = "Which font the system uses.";
      default = "Victor Mono";
    };
    shell = lib.mkOption {
      type = lib.types.string;
      description = "Shell to use";
      default = "zsh";
    };

    vscode = {
      enable = lib.mkEnableOption {
        description = "Enable VSCode.";
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
    obsidian = {
      enable = lib.mkEnableOption {
        description = "Enable Obsidian Notes";
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

    ## OpenGL support
    hardware.opengl = {
      enable = true;
      driSupport32Bit = true;
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
  # };
  imports = [
    # ../themes/catppuccin-macchiato.nix
    ./system/boot.nix
    ./system/filesystem.nix
    ./system/networking.nix
    ./system/fonts.nix
    ./graphical/terminal.nix
    ./shell/zsh.nix
    ./wm/sway.nix
    ./utils.nix
    ./services/xdg.nix
    ./services/pipewire.nix
    ./services/vpn.nix
    ./services/syncthing.nix
    ./services/bluetooth.nix
    ./services/pipewire.nix
    ./services/docker.nix
    ./graphical/notetaking.nix
    ./graphical/thunderbird.nix
    ./graphical/vscode.nix
    ./graphical/browsers/firefox.nix
    # we cant have nice, clean things such as this:
    # (lib.mkIf config.docker.enable ./services/docker.nix)
    # because of silly infinite recursion errors :(
  ];
}
