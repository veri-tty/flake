{
  config,
  lib,
  pkgs,
  ...
}:
{

  imports = [
    ./sway
    ./mail
    ./neovim
    ./programming
    ./gaming
    ./shell
  ];

  options = {
    user = lib.mkOption {
      type = lib.types.str;
      description = "Primary user of the system";
    };
    gh-user = lib.mkOption {
      type = lib.types.str;
      description = "GitHub username";
    };
    gui = {
      enable = lib.mkEnableOption {
        description = "Enable graphical stuffs";
        default = false;
      };
    }; 
    homePath = lib.mkOption {
      type = lib.types.path;
      description = "Path of user's home directory.";
      default = builtins.toPath ("/home/${config.user}");
    };
    dotfilesPath = lib.mkOption {
      type = lib.types.path;
      description = "Path of dotfiles repository.";
      default = config.homePath + "/projects/flake";
    };
  };

  # Use the system-level nixpkgs instead of Home Manager's
  home-manager.useGlobalPkgs = true;

  # Install packages to /etc/profiles instead of ~/.nix-profile, useful when
  # using multiple profiles for one user
  home-manager.useUserPackages = true;

  # Pin a state version to prevent warnings
  home-manager.users.${config.user}.home.stateVersion = stateVersion;
  home-manager.users.root.home.stateVersion = stateVersion;  
}