{ ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];    
  };
  system.stateVersion = "24.05"
}
