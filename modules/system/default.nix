{
  config,
  pkgs,
  lib,
  ...
}:
{

  options = {

    passwordHash = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = "Password created with mkpasswd -m sha-512";
      default = null;
      # Test it by running: mkpasswd -m sha-512 --salt "PZYiMGmJIIHAepTM"
    };
  };

  config = {

    # Allows us to declaritively set password
    users.mutableUsers = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${config.user} = {

      # Create a home directory for human user
      isNormalUser = true;

      # Automatically create a password to start
     # hashedPassword = config.passwordHash;

      extraGroups = [
        "wheel" # Sudo privileges
      ];
    };



    home-manager.users.${config.user}.xdg = {

      # Allow Nix to manage the default applications list
      mimeApps.enable = true;

      # Set directories for application defaults
      userDirs = {
        enable = true;
        createDirectories = true;
        documents = "$HOME/docs";
        download = "$HOME/dl";
        music = "$HOME/media/music";
        pictures = "$HOME/media/images";
        videos = "$HOME/media/videos";
        extraConfig = {
          XDG_DEV_DIR = "$HOME/projects";
        };
      };
    };
  };
}