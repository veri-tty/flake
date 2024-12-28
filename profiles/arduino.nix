{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    arduino = {
      enable = lib.mkEnableOption {
        description = "Install Arduino IDE and related tools and drivers or not";
        default = false;
      };
    };
  };
  # ===============================================================================================
  # for Nvidia GPU
  # ===============================================================================================
  config = lib.mkIf config.arduino.enable {
    environment.systemPackages = [pkgs.arduino-ide];
  };
}
