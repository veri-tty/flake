{
  description = "verity's flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };  
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... } @ inputs: {

    nixosConfigurations.roamer = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./nixos/hardware-configuration.nix
        ./nixos/nix-settings.nix
        ./nixos/nixpkgs.nix
        ./nixos/vpn.nix
        ./nixos/locale.nix
	./nixos/foot.nix
	./nixos/crypto.nix
        ./nixos/users.nix
        ./nixos/boot.nix
        ./nixos/fonts.nix
        ./nixos/utils.nix
        ./nixos/shell.nix
        ./nixos/browsers.nix
        ./nixos/hyprland.nix
        ./nixos/virtualisation.nix
        ./nixos/mail.nix
        ./nixos/obsidian.nix
        ./nixos/theme.nix
	./nixos/networking.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.verity= import ./home.nix;
        }
        inputs.nixvim.nixosModules.nixvim
        ./nixos/nvim.nix 
      ];
    };
  };
}
