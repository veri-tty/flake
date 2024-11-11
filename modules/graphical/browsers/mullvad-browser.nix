{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    browser = {
      mullvad = {
        enable = lib.mkEnableOption {
          description = "Enable Mullvad-Browser.";
          default = false;
        };
      };
    };
  };
  config = {
    environment.systemPackages = lib.mkIf config.browser.mullvad.enable [
      pkgs.mullvad-browser
    ];
  };
}
