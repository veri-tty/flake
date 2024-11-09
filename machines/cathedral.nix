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
      inputs.nixos-hardware.nixosModules.common-cpu-amd
      #inputs.nixos-hardware.nixosModules.common-gpu-amd
      #inputs.nixos-hardware.nixosModules.common-gpu-nvidia
      inputs.nixos-hardware.nixosModules.common-pc
      inputs.nixos-hardware.nixosModules.common-pc-ssd

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
          sway.enable = true;
          hyprland.enable = true;
          shell = "zsh";
          machine.isLaptop = false;
          nvidia.enable = true;
          firefox.enable = true;
          schizofox.enable = false;
          keyboard.layout = "de";
          # themeing etc.
          wallpaper = "/home/ml/pics/wallpapers/river_cottage.jpg";
          theme.colors = import ../themes/catppuccin-macchiato.nix;
          font = {
            size = 16;
            mono = "VictorMono";
          };
          gtk.theme = {
            name = "Adwaita-dark";
            package = pkgs.gnome-themes-extra;
          };
          gaming.int-fic.enable = false;
          gaming.wine.enable = true;
          swap.enable = true;
          pgp.enable = true;
          luks.enable = true;
          mullvad.enable = true;
          syncthing.enable = true;
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
          networking.hostName = "cathedral";

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

          boot.kernelModules = ["kvm-amd"];
          boot.kernelPackages = pkgs.linuxPackagesFor pkgs.linux_latest;
          hardware.enableRedistributableFirmware = true;
          hardware.cpu.amd.updateMicrocode = true;
        };
      })

      ../modules/main.nix # Contains options and imports all relevant other modules
    ];
  }
