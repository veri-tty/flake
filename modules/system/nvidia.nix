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
    graphics = {
      extraPackages = with pkgs; [
        libvdpau-va-gl
        vaapiVdpau
        mesa.drivers
      ];
    };

    nvidia.nvidiaSettings = true;
    #nvidia.powerManagement.enable = true;
    #nvidia.powerManagement.finegrained = true;
    nvidia.open = true;
    # nvidia.forceFullCompositionPipeline = true;
    # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
    nvidia.modesetting.enable = true;
    #nvidia.nvidiaPersistenced = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    #nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  #hardware.nvidia-container-toolkit.enable = true;

  environment.systemPackages = with pkgs; [
    # cudatoolkit
  ];
}
