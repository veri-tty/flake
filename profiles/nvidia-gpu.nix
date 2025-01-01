{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    nvidia = {
      enable = lib.mkEnableOption {
        description = "Nvidia or not.";
        default = false;
      };
    };
  };
  # ===============================================================================================
  # for Nvidia GPU
  # ===============================================================================================
  config = lib.mkIf config.nvidia.enable {
    boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
    services.xserver.videoDrivers = ["nvidia"]; # will install nvidia-vaapi-driver by default
    hardware.nvidia = {
      open = false;
      # required by most wayland compositors!
      modesetting.enable = true;
      powerManagement.enable = true;
    };
    hardware.nvidia-container-toolkit.enable = true;
    hardware.graphics = {
      enable = true;
      # needed by nvidia-docker
      enable32Bit = true;
    };

    nixpkgs.config.cudaSupport = false;
  };
}
