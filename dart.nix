{ version ? "2.9.1" }:

{ stdenv, fetchurl, unzip }:

let

  sources = let

    base = "https://storage.googleapis.com/dart-archive/channels";
    stable_version = "stable";
    dev_version = "dev";
    x86_64 = "x64";
    i686 = "ia32";
    aarch64 = "arm64";

  in {
    "2.9.1-x86_64-linux" = fetchurl {
      url = "${base}/${stable_version}/release/${version}/sdk/dartsdk-linux-${x86_64}-release.zip";
      sha256 = "1v8fisjp948r0xp9zakiiz6j0flpnzin4jgl1blingif902j22cf";
    };
  };

in

with stdenv.lib;

stdenv.mkDerivation {

  pname = "dart";
  inherit version;

  nativeBuildInputs = [
    unzip
  ];

  src = sources."${version}-${stdenv.hostPlatform.system}" or (throw "unsupported version/system: ${version}/${stdenv.hostPlatform.system}");

  installPhase = ''
    mkdir -p $out
    cp -R * $out/
    echo $libPath
    patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
             --set-rpath $libPath \
             $out/bin/dart
  '' + optionalString (versionAtLeast version "2.3.0" && stdenv.hostPlatform.system != "i686-linux") ''
    patchelf --interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
             --set-rpath $libPath \
             $out/bin/dartaotruntime
  '';

  libPath = makeLibraryPath [ stdenv.cc.cc ];

  dontStrip = true;

  meta = {
    homepage = "https://www.dartlang.org/";
    maintainers = with maintainers; [ grburst ];
    description = "Scalable programming language, with robust libraries and runtimes, for building web, server, and mobile apps";
    longDescription = ''
      Dart is a class-based, single inheritance, object-oriented language
      with C-style syntax. It offers compilation to JavaScript, interfaces,
      mixins, abstract classes, reified generics, and optional typing.
    '';
    platforms = [ "x86_64-linux" "i686-linux" "aarch64-linux" ];
    license = licenses.bsd3;
  };
}
