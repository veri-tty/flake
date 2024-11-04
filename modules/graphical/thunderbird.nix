{
  config,
  lib,
  pkgs,
  ...
}: {
  ## General mail settings
  config = lib.mkIf config.thunderbird {
    home-manager.users.${config.user} = {
      programs.thunderbird = {
        enable = true;
      };
    };
  };
}
