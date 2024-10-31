{ config, lib, pkgs, ... }:

{
  config = {
    ## Overlaying the package if we're on wayland
    nixpkgs.overlays = lib.mkIf config.os.wayland [
       (self: super: {
        signal-desktop = super.signal-desktop.overrideAttrs (old: {
          preFixup = old.preFixup + ''
            gappsWrapperArgs+=(
              --add-flags "--enable-features=UseOzonePlatform"
              --add-flags "--ozone-platform=wayland"
            )
          '';
        });
      })
    ];
    
    ## Installing the package
    home-manager.users.${config.user}.home.packages = [ pkgs.signal-desktop ];
  };
}

