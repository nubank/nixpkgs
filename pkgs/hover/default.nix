{ buildGoModule, docker, fetchFromGitHub, libGL, makeWrapper, stdenv, xorg, glfw }:

buildGoModule rec {
  pname = "hover";
  version = "0.43.0";

  subPackages = [ "." ];

  vendorSha256 = "1wr08phjm87dxim47i8449rmq5wfscvjyz65g3lxmv468x209pam";

  src = fetchFromGitHub {
    rev = "v${version}";
    owner = "go-flutter-desktop";
    repo = pname;
    sha256 = "0iw6sxg86wfdbihl2hxzn43ppdzl1p7g5b9wl8ac3xa9ix8759ax";
  };

  nativeBuildInputs = [ makeWrapper ];

  patches = [
    ./fix-assets-path.patch
    ./fix-build-docker.patch
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
      --prefix LD_LIBRARY_PATH : ${stdenv.lib.makeLibraryPath [
        libGL
        xorg.libX11
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXrandr
        xorg.libXxf86vm
        xorg.libXext
      ]}
  '';

  meta = with stdenv.lib; {
    description = "A build tool to run Flutter applications on desktop";
    homepage = "https://github.com/go-flutter-desktop/hover";
    license = licenses.bsd3;
    platforms = platforms.linux ++ platforms.darwin;
  };
}
