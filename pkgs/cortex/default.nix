{
  buildFHSUserEnv,
  stdenv,
  fetchurl,
  makeWrapper,
  lib,
  pkgs
}:

let

  cortex = stdenv.mkDerivation rec {
    pname = "cortex";
    rev = "123";
    version = "2021.2.1";

    src = ../../../ansible-pull/common/files/nubank-global-install-linux-762.deb;

    nativeBuildInputs = [ makeWrapper ];
    buildInputs = with pkgs; [ dpkg getopt openssl ];

    unpackPhase = "dpkg-deb -x ${src} ./";

    patches = [
      ./fix-setup.patch
    ];

    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/log
      mkdir -p $out/share

      patchShebangs ./opt/traps/deb-installer/setup.sh
      for file in ./opt/traps/deb-installer/setup.d/*; do
        chmod +w $file
        patchShebangs $file
        # patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
        #          --set-rpath ${lib.makeLibraryPath [ pkgs.stdenv.cc.cc ]} \
        #          $file
      done

      cd ./opt/traps/deb-installer
      ./setup.sh
    '';

    dontPatchELF = true;
  };
in buildFHSUserEnv {
  name = cortex.name;
  targetPkgs = pkgs: [ cortex ];

  runScript = "cortex";
}
