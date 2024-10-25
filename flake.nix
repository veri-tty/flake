{
  description = "My NixOS configuration";

  ## Inputs
  ##
  ## Using latest commits for both nixpkgs and home-manager
  ## to make NixOS rolling release.
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    musnix  = { url = "github:musnix/musnix"; };
    audio.url = "github:polygon/audio.nix";
    nur.url = "github:nix-community/NUR";
    tuxedo-nixos = {
      url = "github:blitz/tuxedo-nixos";
   };
  };

  outputs = { nixpkgs, nixos-hardware, ... }@inputs:
  let

    ## Global variables used throughout the configuration
    globals = rec {
      user = "ml";
      fullName = "veri-tty";
      stateVersion = "24.05";
    };

    overlays = [
      inputs.nur.overlay
      inputs.audio.overlays.default
    ];

    supportedSystems = [ "x86_64-linux" ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

  in rec {

    ## System configurations
    nixosConfigurations = {
      roamer = import ./machines/roamer.nix { inherit inputs globals nixpkgs nixos-hardware overlays; };
    };

    ## Home configurations
    homeConfigurations = {
      roamer = nixosConfigurations.roamer.config.home-manager.users.${globals.user}.home;
    };
  };
}
