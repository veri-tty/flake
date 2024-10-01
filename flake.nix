{
  description = "verity's flake";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    };
  };

  outputs = { nixpkgs, ... } @ inputs:
  {
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
      ];
    };
  };
}
