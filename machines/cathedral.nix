{
  inputs,
  globals,
  #lib,
  pkgs,
  ...
}:
with inputs;
  nixpkgs.lib.nixosSystem {
    ## Setting system architecture.
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};

    ## Modules
    ##
    ## It takes an array of modules.
    modules = [
      stylix.nixosModules.stylix
      inputs.agenix.nixosModules.default
      inputs.spicetify-nix.nixosModules.default
      inputs.nixos-cosmic.nixosModules.default
      pkgs.nur.nixosModules.nur
      home-manager.nixosModules.home-manager
      ## Applying recommended hardware settings
      inputs.nixos-hardware.nixosModules.common-cpu-amd
      #inputs.nixos-hardware.nixosModules.common-gpu-amd
      #inputs.nixos-hardware.nixosModules.common-gpu-nvidia
      inputs.nixos-hardware.nixosModules.common-pc
      inputs.nixos-hardware.nixosModules.common-pc-ssd
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
          wm = {
            sway.enable = false;
            cosmic.enable = true;
            hyprland.enable = true;
            plasma-6.enable = false;
          };
          shell = "zsh";
          machine.isLaptop = false;
          nvidia.enable = true;
          browser = {
            firefox.enable = true;
          };
          keyboard.layout = "de";
          # themeing etc.
          wallpaper = "/home/ml/pics/wallpapers/stalenhag-street.jpg";
          theme.colors = import ../themes/solarized.nix;
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
          gaming.lutris.enable = true;
          swap.enable = true;
          pgp.enable = true;
          luks.enable = true;
          #vm.windows.enable = true;
          mullvad.enable = true;
          syncthing.enable = true;
          tailscale.enable = true;
          spotify.enable = true;
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
          hardware.enableAllFirmware = true;
          hardware.cpu.amd.updateMicrocode = true;
          services.xserver.videoDrivers = [
            "nvidia"
          ];
        };
      })

      ../modules/main.nix # Contains options and imports all relevant other modules
    ];
  }
