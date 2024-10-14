{ pkgs, ... }:

{
  services = {
    syncthing = {
        enable = true;
        user = "verity";
        dataDir = "/home/verity/docs";    # Default folder for new synced folders
        configDir = "/home/verity/.config/syncthing";   # Folder for Syncthing's settings and keys
  };
};


  
