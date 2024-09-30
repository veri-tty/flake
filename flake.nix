{
  description = "verity's flake";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
      home-manager = {
        url = "github:nix-community/home-manager/release-24.05";
        inputs.nixpkgs.follows = "nixpkgs";
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
      ];
    };
  };
}
