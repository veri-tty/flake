{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.nvidia.enable {
  services.xserver = {
    videoDrivers = ["nvidia"];
  };
  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    nvidia.nvidiaSettings = true;
    nvidia.open = false;
    nvidia.modesetting.enable = true;
  };
}
