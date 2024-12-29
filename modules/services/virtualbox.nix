{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    virtualbox = {
      enable = lib.mkEnableOption {
        description = "Enable Virtualbox VM Service";
        default = false;
      };
    };
  };
  config = {
    environment.systemPackages = lib.mkIf config.virtualbox.enable [
      pkgs.virtualbox
    ];
  };
}
