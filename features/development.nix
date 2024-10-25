{ config, lib, pkgs, ... }:

{
  imports = [
    ## Reverse import the wrapper feature so that the options are defined.
    ../features

    ## Browsers
    ../modules/browsers/chromium.nix
    ../modules/browsers/firefox.nix

    ## IDE
    #../modules/development/webstorm.nix
    ../modules/development/vscode.nix
    

    ## Tools
    ../modules/common/services/docker.nix
  ];

  config = {  
    ## Setting the appropriate option so other modules know it.
    features.development = true;
  };
}
