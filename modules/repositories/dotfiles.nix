{ config, lib, pkgs, ... }:

{
  imports = [
    ## Import the configuration so we know where to clone
    ../repositories
  ];

  options = {
    repositories = {
      dotfiles = {
        path = lib.mkOption {
          type = lib.types.path;
          description = "Path where the dotfiles should be cloned";
          default = "${config.repositories.path}/dots";
        };

        repo = lib.mkOption {
          type = lib.types.str;
          description = "URL of the dotfiles repo";
          default = "git@github.com:veri-tty/flake.git";
        };
      };
    };
  };

  config = {
    home-manager.users.${config.user} = {
      home.activation = {
        cloneDotfiles =
            ## Source: https://github.com/nmasur/dotfiles/blob/cd0c93c6d9a7dfa5ed061a850140f7f4f8bc9323/modules/common/repositories/dotfiles.nix
            config.home-manager.users.${config.user}.lib.dag.entryAfter
            [ "writeBoundary" ] ''
              if [ ! -d "${config.repositories.dotfiles.path}" ]; then
                  $DRY_RUN_CMD mkdir --parents $VERBOSE_ARG $(dirname "${config.repositories.dotfiles.path}")

                  # Force HTTPS because anonymous SSH doesn't work
                  GIT_CONFIG_COUNT=1 \
                      GIT_CONFIG_KEY_0="url.https://github.com/.insteadOf" \
                      GIT_CONFIG_VALUE_0="git@github.com:" \
                      $DRY_RUN_CMD \
                      ${pkgs.git}/bin/git clone ${config.repositories.dotfiles.repo} "${config.repositories.dotfiles.path}"
              fi
            '';
      };
    };
  };
}

