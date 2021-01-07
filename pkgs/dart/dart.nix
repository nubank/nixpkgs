{ version ? "2.10.4", channel, sha256Hash }:

{ stdenv, fetchurl, unzip }:

let

  sources = let
    base = "https://storage.googleapis.com/dart-archive/channels";
  in
    {
      "${version}-x86_64-linux" = fetchurl {
        url = "${base}/${channel}/release/${version}/sdk/dartsdk-linux-x64-release.zip";
        sha256 = sha256Hash;
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
      find $out/bin -executable -type f -exec patchelf --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) {} \;
    '';

    libPath = makeLibraryPath [ stdenv.cc.cc ];

    dontStrip = true;

    meta = {
      homepage = "https://www.dartlang.org/";
      description = "Scalable programming language, with robust libraries and runtimes, for building web, server, and mobile apps";
      longDescription = ''
        Dart is a class-based, single inheritance, object-oriented language
        with C-style syntax. It offers compilation to JavaScript, interfaces,
        mixins, abstract classes, reified generics, and optional typing.
      '';
      platforms = [ "x86_64-linux" ];
      license = licenses.bsd3;
    };
  }
