{
  config,
  lib,
  pkgs,
  ...
}: {
  ## Setting the appropriate option so other modules know it
  options = {
    os = {
      wm = lib.mkOption {
        type = lib.types.str;
        description = "Window manager used throughout the system";
      };
    };
  };

  config = {
    ## Start WM if logging into TTY1
    environment.loginShellInit = ''
      [[ "$(tty)" == /dev/tty1 ]] && ${config.os.wm}
    '';
  };
}
