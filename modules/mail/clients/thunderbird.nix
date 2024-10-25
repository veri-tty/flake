{ config, lib, pkgs, ... }:

{
  ## General mail settings
  config = lib.mkIf config.mail.clients.thunderbird.enable {
    home-manager.users.${config.user} = {
      programs.thunderbird = {
        enable = true;
        # profiles = {
        #   work = {
        #     isDefault = true;
        #     withExternalGnupg = true;
        #   };
        # };
        settings = {
          "mail.identity.default.is_gnupg_key_id" = true;
          "mail.identity.default.last_entered_external_gnupg_key_id" = "${config.const.signingKey}";
          "mail.openpgp.fetch_pubkeys_from_gnupg" = true;
        };
      };
    };
  };
}
