{ buildGoModule, docker, fetchFromGitHub, libGL, libX11, libXcursor, libXi,
  libXinerama, libXrandr, libXxf86vm, makeWrapper, stdenv, xorg}:

buildGoModule rec {
  pname = "hover";
  version = "unstable-2020-07-17";

  subPackages = [ "." ];

  vendorSha256 = "1wr08phjm87dxim47i8449rmq5wfscvjyz65g3lxmv468x209pam";

  src = fetchFromGitHub {
    rev = "aa3008e561afca8f5f0c8e796123140f361ffc8f";
    owner = "go-flutter-desktop";
    repo = pname;
    sha256 = "0r52qly6qcqihnyz8mkgqnaz75pawc5r318g7mfl84yi4f29gbw6";
  };

  nativeBuildInputs = [ makeWrapper ];

  patches = [
    ./patches/hover/fix-assets-path.patch
    ./patches/hover/fix-build-docker.patch
  ];
  postPatch = ''
    sed -i 's|@assetsFolder@|'"''${out}/share/assets"'|g' internal/fileutils/assets.go
  '';

  postInstall = ''
    mkdir -p $out/share
    cp -r assets $out/share/assets
    chmod -R a+rx $out/share/assets

    wrapProgram "$out/bin/hover" \
      --prefix PATH : ${stdenv.lib.makeBinPath [ docker ]} \
      --prefix LD_LIBRARY_PATH : ${stdenv.lib.makeLibraryPath [ xorg.libXext libX11 libXcursor libXinerama libXrandr libXxf86vm libXi libGL]}
  '';

  meta = with stdenv.lib; {
    description = "A build tool to run Flutter applications on desktop";
    homepage = "https://github.com/go-flutter-desktop/hover";
    license = licenses.bsd3;
    platforms = platforms.linux ++ platforms.darwin;
  };
}
