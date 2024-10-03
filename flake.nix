{
  description = "verity's flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.05";
    };  
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixvim, ... } @ inputs: {

    nixosConfigurations.roamer = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./nixos/hardware-configuration.nix
        ./nixos/nix-settings.nix
        ./nixos/nixpkgs.nix
        ./nixos/vpn.nix
        ./nixos/locale.nix
        ./nixos/users.nix
        ./nixos/gnome.nix
        ./nixos/boot.nix
        ./nixos/fonts.nix
        ./nixos/utils.nix
        ./nixos/shell.nix
        ./nixos/browsers.nix
        ./nixos/hyprland.nix
        ./nixos/home-manager.nix
        ./nixos/virtualisation.nix
        ./nixos/mail.nix
        ./nixos/obsidian.nix
	nixvim.nixosModules.nixvim
        ./nixos/nvim.nix
      ];
    };
  };
}
