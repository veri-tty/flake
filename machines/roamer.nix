{
  inputs,
  globals,
  overlays,
  ...
}:
with inputs;
  nixpkgs.lib.nixosSystem {
    ## Setting system architecture.
    system = "x86_64-linux";

    ## Modules
    ##
    ## It takes an array of modules.
    modules = [
      ## Passing our recursive list will set the variables it contains
      ## config-wide as long as we declare them as options using `mkOption'.
      globals

      ## This module will return a `home-manager' object that can be used
      ## in other modules (including this one).
      home-manager.nixosModules.home-manager
      {
        nixpkgs.overlays = overlays;
      }

      ## This module will return a `nur' object that can be used to access
      ## NUR packages.
      nur.nixosModules.nur

      ## Applying recommended hardware settings
      nixos-hardware.nixosModules.common-cpu-intel
      nixos-hardware.nixosModules.common-pc-laptop
      nixos-hardware.nixosModules.common-pc-ssd

      ## System specific
      ##
      ## Closure that returns the module containing configuration specific
      ## to this machine. In order to make it a function we need to wrap it
      ## in ().
      ({
        lib,
        config,
        pkgs,
        ...
      }: {
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
        mail.clients.thunderbird.enable = true;
        os.machine.isLaptop = true;
        os.keyboard.layout = "de";
        os.output.primary.width = "2256";
        os.output.primary.height = "1504";
        os.shell = "zsh";
        os.fonts.mono.regular = "Victor Mono";
        wallpaper = "/home/ml/pics/wallpapers/nix-black-4k.png";
        mail.work.enable = false;
        os.output.primary.name = "eDP-1";
        theme = {
          colors = (import ../colorscheme/catppuccin-macchiato).dark;
        };
        gtk.theme.name = inputs.nixpkgs.lib.mkDefault "Adwaita-dark";
        console = {
          font = "Lat2-Terminus16";
          keyMap = config.os.keyboard.layout;
        };

        users.users.${config.user} = {
          extraGroups = ["wheel" "video" "input"];
          isNormalUser = true;
        };
      })

      ## Host agnostic modules
      ##
      ## A list of file paths containing modules that should be used on this
      ## machine. They are not specific to this machine and can be used on
      ## other machines too as long as it fits their purpose.
      ../modules/common

      ## Hardware specific modules
      ../modules/hardware/backlight.nix

      ## Features
      ## Sets of modules for a specific purpose
      ../features/development.nix

      ## Chat
      ../modules/chat/discord.nix
      #../modules/chat/slack.nix
      #../modules/chat/signal.nix
    ];
  }
