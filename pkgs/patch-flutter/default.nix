{ pkgs, stdenv }:

let
  patchFlutter = pkgs.writeShellScriptBin "patch-flutter" ''
    usage() {
      cat <<EOT
    Patch vanilla Flutter SDK installation to work in NixOS.

    Usage:
      patch-flutter FLUTTER_SDK_PATH
    EOT
      exit 1
    }

    isScript() {
        local fn="$1"
        local fd
        local magic
        exec {fd}< "$fn"
        read -r -n 2 -u "$fd" magic
        exec {fd}<&-
        if [[ "$magic" =~ \#! ]]; then return 0; else return 1; fi
    }

    stopNest() { true; }

    patchFlutterSdk() {
      source "${<nixpkgs/pkgs/build-support/setup-hooks/patch-shebangs.sh>}"
      patchShebangs --build "$1/bin/"
      find "$1/bin/" -executable -type f -exec "${pkgs.patchelf}/bin/patchelf" --set-interpreter "${pkgs.glibc}/lib/ld-linux-x86-64.so.2" {} \;
    }

    if [ "$#" -lt 1 ]; then
      usage
    fi

    patchFlutterSdk "$@"
  '';
in
stdenv.mkDerivation {
  name = "patch-flutter";
  unpackPhase = "true";

  meta = with stdenv.lib; {
    description =
      "Script to patch a vanilla Flutter SDK installation to work in NixOS.";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -r ${patchFlutter}/bin $out
  '';

  buildInputs = [ patchFlutter ];
}
