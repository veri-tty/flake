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

    stateVers = lib.mkOption {
      # is defined in flake.nix
      type = lib.types.str;
      description = "State version of nixos and home-manager";
    };
    wayland = {
      enable = lib.mkEnableOption {
        description = "Wayland or not.";
        default = false;
      };
    };
    pgp = {
      enable = lib.mkEnableOption {
        description = "Enable PGP, Gnupgp and all that shabang";
        default = false;
      };
    };

    syncthing = {
      enable = lib.mkEnableOption {
        description = "Enable Syncthing Service";
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
    ./graphical/browsers
    ./graphical/wm
    ./graphical/editors
    ./graphical
    ./system
    ../profiles
    ./services
  ];
}
