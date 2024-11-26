{
  config,
  pkgs,
  lib,
  ...
}: let
  notflix = pkgs.stdenv.mkDerivation {
    pname = "notflix";
    version = "latest";
    src = pkgs.fetchFromGitHub {
      owner = "Bugswriter";
      repo = "notflix";
      rev = "master";
      sha256 = "rl0yB5H/S0YX/pRxvJjjzcA6dkbhTKjXx8gkK/47pW4=";
    };
    installPhase = ''
      mkdir -p $out/bin
      cp -r * $out/bin
      chmod +x $out/bin/notflix
    '';
  };
in {
  environment.systemPackages = with pkgs; [
    nodePackages.peerflix
    notflix
    mpv
  ];
}
