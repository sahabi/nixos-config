with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "usb-1.0";
  src = ./usb-1.0;
  unpackPhase = "true";
  buildPhase = ''
    true
    '';
  installPhase = ''
    mkdir -p $out/bin
    cp /etc/nixos/usb-1.0/usb $out/bin
    '';
}
