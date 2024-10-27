{ config, lib, pkgs, ... }:

{
  services.pcscd.enable = true;
  programs.gnupg.agent = {
   enable = true;
   pinentryPackage = pkgs.pinentry-rofi;
   enableSSHSupport = true;
  };
  environment.systemPackages = [
    pkgs.pinentry-all
  ];
  home-manager.users.${config.user} = {

    programs = {
      ## Enable git
      git.enable = true;
      
      ## Set username and email according to predefined options
      git.userName = "${config.fullName}";
      git.userEmail = "${config.mail.address}";

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

