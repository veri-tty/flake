{ pkgs, ... }:

{
  users.users.verity = {
    isNormalUser = true;
    description = "verity";
    extraGroups = [ "networkmanager" "input" "wheel" "video" "audio" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      spotify
      vscodium
      brave
    ];
  };
}
