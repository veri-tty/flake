{
  lib,
  config,
  ...
}: {
  imports = [
    ./firefox.nix
    #./brave.nix
    ./mullvad-browser.nix
  ];
  options = {
    gui = {
      enable = lib.mkEnableOption {
        description = "Enable graphics.";
        default = false;
      };
    };
  };
}
