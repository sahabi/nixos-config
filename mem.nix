with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "mem-1.0";
  src = ./mem-1.0;
  unpackPhase = "true";
  buildPhase = ''
    true
    '';
  installPhase = ''
    mkdir -p $out/bin
    cp /etc/nixos/mem-1.0/mem $out/bin
    '';
}
