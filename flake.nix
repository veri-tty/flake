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
        ./hardware-configuration.nix
        ./nix-settings.nix
	./sync.nix
	./code.nix
        ./nixpkgs.nix
	./rust.nix
        ./vpn.nix
        ./locale.nix
	./foot.nix
	./crypto.nix
        ./users.nix
        ./boot.nix
        ./fonts.nix
        ./utils.nix
        ./shell.nix
        ./browsers.nix
        ./hyprland.nix
        ./virtualisation.nix
        ./mail.nix
        ./obsidian.nix
        ./theme.nix
	./networking.nix
	./home-manager.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.verity= import ./home.nix;
        }
        inputs.nixvim.nixosModules.nixvim
        ./nvim.nix 
      ];
    };
  };
}
