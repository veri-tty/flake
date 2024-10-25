{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.git = {
    enable = true;
    userName  = "veri-tty";
    userEmail = "verity@cock.li";
  };

  home-manager.users.${config.user} = {

    programs.gh = lib.mkIf config.home-manager.users.${config.user}.programs.git.enable {
      enable = true;
      gitCredentialHelper.enable = true;
      settings.git_protocol = "https";
      extensions = [
        pkgs.gh-collaborators
        pkgs.gh-dash
      ];
    }; 
  };
}