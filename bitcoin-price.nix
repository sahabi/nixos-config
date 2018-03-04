with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "bitcoin-price-1.0";
  src = ./bitcoin-price-1.0;
  unpackPhase = "true";
  buildPhase = ''
    true
    '';
  installPhase = ''
    mkdir -p $out/bin
    cp /etc/nixos/bitcoin-price-1.0/bitcoin-price $out/bin
    '';
}
