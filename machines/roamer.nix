{
  inputs,
  globals,
  ...
}:
with inputs;
  nixpkgs.lib.nixosSystem {
    ## Setting system architecture.
    system = "x86_64-linux";
    specialArgs = {inherit inputs nur;};

    ## Modules
    ##
    ## It takes an array of modules.
    modules = [
      nur.nixosModules.nur
      home-manager.nixosModules.home-manager
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
          user = "ml";
          fullName = "veri-tty";
          mail.git = "verity@cock.li";
          gui.enable = true;
          wayland.enable = true;
          stateVers = "24.05";
          wm.sway.enable = false;
          wm.hyprland.enable = true;
          shell = "zsh";
          qbit.enable = true;
          machine.isLaptop = true;
          nvidia.enable = false;
          arduino.enable = true;
          browser = {
            firefox.enable = true;
          };
          #schizofox.enable = false;
          keyboard.layout = "de";
          gaming.int-fic.enable = true;
          gaming.wine.enable = false;
          gaming.steam.enable = true;
          syncthing.enable = true;
          # themeing etc.
          wallpaper = "/home/ml/pics/wallpapers/nix-black-4k.png ";
          theme.colors = import ../themes/catppuccin-macchiato.nix;
          font = {
            size = 16;
            mono = "VictorMono";
          };
          gtk.theme = {
            name = "Adwaita-dark";
            package = pkgs.gnome-themes-extra;
          };
          swap.enable = true;
          luks.enable = true;
          pgp.enable = true;
          mullvad.enable = true;
          tailscale.enable = true;
          thunderbird.enable = true;
          obsidian.enable = true;
          vscode.enable = true;
          docker.enable = true;

          console = {
            font = "VictorMono";
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
        };
      })

      ../modules/main.nix # Contains options and imports all relevant other modules
    ];
  }
