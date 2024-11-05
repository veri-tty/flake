{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.${config.user} = {
    services.gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
    services.gnome-keyring.enable = true;
    programs = {
      ## Enable git
      git.enable = true;
      gpg.enable = true;
      ## Set username and email according to predefined options
      git.userName = "${config.fullName}";
      git.userEmail = "${config.mail.git}";

      ## Set up signing key and auto-sign commits
      #git.signing.key = "${config.const.signingKey}";
      #git.signing.signByDefault = true;

      ## Extra config
      git.extraConfig = {
        pull = {
          rebase = false;
        };
      };
      gh = {
        enable = true;
      };
    };
  };
}
