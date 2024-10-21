# The Tempest
# System configuration for my desktop

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
    ../../modules/common
    ../../modules/nixos
  
    {
      nixpkgs.overlays = overlays;

      # Hardware
      physical = true;
      networking.hostName = "roamer";
  
      # Not sure what's necessary but too afraid to remove anything
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
      # Graphics and VMs
      boot.kernelModules = [ "kvm-intel" ];

      # Required binary blobs to boot on this machine
      hardware.enableRedistributableFirmware = true;

      # Prioritize performance over efficiency
      powerManagement.cpuFreqGovernor = "performance";

      # Allow firmware updates
      hardware.cpu.intel.updateMicrocode = true;


      # Luks-Crypt 
      boot.initrd.luks.devices."luks-df9bdee0-856b-465a-b975-ae56715d226e".device = "/dev/disk/by-uuid/df9bdee0-856b-465a-b975-ae56715d226e";

      # This is the root filesystem containing NixOS
      fileSystems."/" = {
        device = "/dev/disk/by-uuid/6469d818-5cb2-4387-8aa1-f16e02856b3d";
        fsType = "ext4";
      };

      # Grub or some shit
      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/7A9E-FA13";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/be3fac39-e827-42c5-8b9f-19a45a64e209"; }
      ];


      # Turn on all features related to desktop and graphical applications
      gui.enable = true;

      # Set the system-wide theme, also used for non-graphical programs
      theme = {
        colors = (import ../../colorscheme/catppuccin-macchiato).dark;
        dark = true;
      };
      wallpaper = "/home/malu/pics/nix-magenta.png";
      gtk.theme.name = inputs.nixpkgs.lib.mkDefault "Adwaita-dark";

      # Programs and services
      neovim.enable = true;
      media.enable = true;
      dotfiles.enable = true;
      firefox.enable = true;
      kitty.enable = true;
      discord.enable = true;
      nautilus.enable = true;
      obsidian.enable = true;
      mail.enable = false;
      mail.aerc.enable = false;
      mail.himalaya.enable = false;
      keybase.enable = false;
      mullvad.enable = true;
      rust.enable = true;
      syncthing.enable = true;
      terraform.enable = false;
      wezterm.enable = false;
      yt-dlp.enable = false;
      gaming = {
        dwarf-fortress.enable = true;
        enable = true;
        steam.enable = false;
        moonlight.enable = false;
        legendary.enable = false;
        lutris.enable = false;
        ryujinx.enable = false;
      };
      services.openssh.enable = true; # Required for Cloudflare tunnel and identity file
    }
  ];
}
