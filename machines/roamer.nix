{inputs, ...}:
with inputs;
  nixpkgs.lib.nixosSystem {
    ## Setting system architecture.
    system = "x86_64-linux";

    ## Modules
    ##
    ## It takes an array of modules.
    modules = [
      home-manager.nixosModules.home-manager
      nur.nixosModules.nur
      ## Applying recommended hardware settings
      nixos-hardware.nixosModules.common-cpu-intel
      nixos-hardware.nixosModules.common-pc-laptop
      nixos-hardware.nixosModules.common-pc-ssd

      ## System specific
      ## Closure that returns the module containing configuration specific
      ## to this machine. In order to make it a function we need to wrap it
      ## in ().
      ({
        lib,
        config,
        pkgs,
        ...
      }: {
        config = {
          gui.enable = true;
          stateVers = "24.05";
          windowmanager = "sway";
          shell = "zsh";
          machine.isLaptop = true;
          keyboard.layout = "de";
          # themeing etc.
          wallpaper = "/home/ml/pics/wallpapers/yosemite.jpg";
          theme = "catppuccin-macchiato";
          font.mono.regular = "Victor Mono";
          gtk.theme.name = "Catppuccin-Macchiato";
          swap.enable = true;
          luks.enable = true;
          mullvad.enable = true;
          tailscale.enable = true;
          thunderbird.enable = true;
          obsidian.enable = true;
          vscode.enable = true;
          docker.enable = true;

          console = {
            font = "Victor Mono";
            keyMap = config.keyboard.layout;
          };

          users.users.${config.user} = {
            extraGroups = ["wheel" "video" "input"];
            isNormalUser = true;
          };
          ## networking
          networking.hostName = "roamer";

          ## kernel
          boot.initrd.kernelModules = ["vmd"];
          boot.initrd.availableKernelModules = [
            "xhci_pci"
            "thunderbolt"
            "vmd"
            "nvme"
            "usb_storage"
            "sd_mod"
          ];

          boot.kernelModules = ["kvm-intel"];
          boot.kernelPackages = pkgs.linuxPackagesFor pkgs.linux_latest;
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
          hardware.enableRedistributableFirmware = true;
          hardware.cpu.intel.updateMicrocode = true;

          hardware.opengl = {
            extraPackages = with pkgs; [
              intel-media-driver # LIBVA_DRIVER_NAME=iHD
              vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
              vaapiVdpau
              libvdpau-va-gl
            ];
          };
        };
      })

      ../modules/main.nix # Contains options and imports all relevant other modules
    ];
  }
