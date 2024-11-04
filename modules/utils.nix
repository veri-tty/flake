{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.${config.user} = {
    services = {
      ## Enable gpg-agent with ssh support
      gpg-agent = {
        enable = true;
        enableSshSupport = true;
        enableZshIntegration = config.shell == "zsh";
        #pinentryFlavor = "qt";
      };

      ## Add SSH key
      gpg-agent.sshKeys = ["E3FFA5A1B444A4F099E594758008C1D8845EC7C0"];
    };

    programs = {
      gpg = {
        ## Enable GnuPG
        enable = true;

        homedir = "${config.user}/.config/gnupg";
      };
    };
  };
}
