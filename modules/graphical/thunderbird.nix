{
  config,
  lib,
  pkgs,
  ...
}: {
  ## General mail settings
  home-manager.users.${config.user} = {
    programs.thunderbird = lib.mkIf config.thunderbird.enable {
      enable = true;
      profiles.verity = {
        isDefault = true;
      };
    };
  };
}
