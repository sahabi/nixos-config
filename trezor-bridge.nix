with import <nixpkgs> {};
stdenv.mkDerivation rec {
  name = "TREZOR-bridge-1.0.5";

  passthru = {
    mozillaPlugin = "/lib/mozilla/plugins";
  };

  src =
      fetchurl {
        url    = https://wallet.trezor.io/data/bridge/2.0.9/trezor-bridge_2.0.9_amd64.deb;
        sha256 = "d67a9a2483095c5bb52653022f40469406c800bf3c32b4d29272bfee25f9bc37";
      };

  phases = [ "unpackPhase" "installPhase" "fixupPhase" ];

  dontStrip = true;
  dontPatchELF = true;

  unpackPhase = "${dpkg}/bin/dpkg-deb -x $src .";

  installPhase = ''
    mkdir -p $out/etc/udev/rules.d/
    cp ./lib/udev/rules.d/51-trezor.rules $out/etc/udev/rules.d/
  '';

  meta = with stdenv.lib;
    { description = "Plugin for browser to TREZOR device communication";
      homepage = https://mytrezor.com;
      license = licenses.unfree;
      maintainers = with maintainers; [ ehmry ];
      # Download URL, .deb content & hash (yikes) changed, not version.
      # New archive doesn't contain any Mozilla plugin at all.
    };

}
