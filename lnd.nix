with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "lnd-0.4.0";
  src = ./lnd-0.4.0;
  unpackPhase = "true";
  buildPhase = ''
    true
    '';
  installPhase = ''
    mkdir -p $out/bin
    cp /etc/nixos/lnd-0.4.0/lncli $out/bin
    cp /etc/nixos/lnd-0.4.0/lnd $out/bin
    '';
}
