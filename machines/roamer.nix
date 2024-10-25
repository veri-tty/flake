# roamer
# System configuration for my surface laptop 3

{
  inputs,
  globals,
  overlays,
  ...
}:


inputs.nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";
  specialArgs = {
    pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
  };
  modules = [
    globals
    inputs.home-manager.nixosModules.home-manager
    ../../modules/dev
    ../../modules/gaming
    #../../modules/sway
    ../../modules/system
  ];
  
  gui.enable = true;
  development.enable = true;
  chromium.enable = true;
  gaming = {
    enable = true;
    dwarf-fortress.enable = true;
  };

  require = [ 
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-pc-ssd 
  ];


  # Hardware
  physical = true;
  networking.hostName = "roamer";
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
    ];
    boot.initrd.luks.cryptoModules = [
    "aes"
    "aes_generic"
    "blowfish"
    "twofish"
    "serpent"
    "cbc"
    "xts"
    "lrw"
    "sha1"
    "sha256"
    "sha512"
    "af_alg"
    "algif_skcipher"
    # neccisary due to sl3 specific hardware fuckups with encryption https://github.com/linux-surface/linux-surface/wiki/Disk-Encryption
    "surface_aggregator"
    "surface_aggregator_registry"
    "surface_aggregator_hub"
    "surface_hid_core"
    "8250_dw"
    "surface_hid"
    "intel_lpss"
    "intel_lpss_pci"
    "pinctrl_icelake"
    ];

    # Gimme that spyware
    nixpkgs.config.allowUnfree = true;
    
    # Graphics and VMs
    boot.kernelModules = [ "kvm-intel" ];

    # Required binary blobs to boot on this machine
    hardware.enableRedistributableFirmware = true;

    # Prioritize performance over efficiency
    powerManagement.cpuFreqGovernor = "performance";

    # Allow firmware updates
    hardware.cpu.intel.updateMicrocode = true;

    # Luks-Crypt 
    boot.initrd.luks.devices."cryptroot".device = "/dev/nvme0n1p2";

    # This is the root filesystem containing NixOS
    fileSystems."/" = {
    device = "/dev/vg0/root";
    fsType = "ext4";
    };

    # Grub or some shit
    fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
    };
    swapDevices = [
      { device = "/dev/vg0/swap"; }
    ];
    system.stateVersion = "24.05";
}
   
