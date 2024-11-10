{
  config,
  lib,
  pkgs,
  ...
}: {
  # ===============================================================================================
  # for Nvidia GPU
  # ===============================================================================================

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
}
