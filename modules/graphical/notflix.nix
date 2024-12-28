{
  config,
  pkgs,
  lib,
  ...
}: let
  notflix = pkgs.stdenvNoCC.mkDerivation {
    pname = "notflix";
    version = "latest";
    src = pkgs.fetchFromGitHub {
      owner = "Bugswriter";
      repo = "notflix";
      rev = "018943da49dfb8467189709505564404319f0712";
      sha256 = "rl0yB5H/S0YX/pRxvJjjzcA6dkbhTKjXx8gkK/47pW4=";
    };
    installPhase = ''
       mkdir -p $out/bin
       cp -r $src/* $out/bin
      # chmod +x $out/bin/notflix
    '';
  };
in {
  environment.systemPackages = with pkgs; [
    nodePackages.peerflix
    notflix
    mpv
  ];
}
