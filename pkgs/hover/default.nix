{ lib, buildGoModule, buildFHSUserEnv, pkgconfig, fetchFromGitHub,
  stdenv, writeScript, xorg, libglvnd, addOpenGLRunpath, makeWrapper,
  gcc, go, flutter }:

let
  pname = "hover";
  version = "0.43.0";

  libs = with xorg; [
    libXi
    libXxf86vm
    libglvnd.dev
    libX11.dev
    libXcursor.dev
    libXinerama.dev
    libXrandr.dev
    libXrender.dev
    xorgproto
  ];
in buildGoModule rec {
  inherit pname version;

  meta = with stdenv.lib; {
    description = "A build tool to run Flutter applications on desktop";
    homepage = "https://github.com/go-flutter-desktop/hover";
    license = licenses.bsd3;
    platforms = platforms.linux ++ platforms.darwin;
  };

  subPackages = [ "." ];

  vendorSha256 = "1wr08phjm87dxim47i8449rmq5wfscvjyz65g3lxmv468x209pam";

  src = fetchFromGitHub {
    rev = "v${version}";
    owner = "go-flutter-desktop";
    repo = pname;
    sha256 = "0iw6sxg86wfdbihl2hxzn43ppdzl1p7g5b9wl8ac3xa9ix8759ax";
  };

  nativeBuildInputs = [ addOpenGLRunpath makeWrapper ];

  propagatedBuildInputs = [
    flutter
    gcc
    go
    pkgconfig
  ] ++ libs;

  checkRun = false;

  patches = [
    ./fix-assets-path.patch
  ];

  postPatch = ''
    sed -i 's|@assetsFolder@|'"''${out}/share/assets"'|g' internal/fileutils/assets.go
  '';

  postInstall = ''
    mkdir -p $out/share
    cp -r assets $out/share/assets
    chmod -R a+rx $out/share/assets

    wrapProgram "$out/bin/hover" \
      --prefix CPATH : ${xorg.libX11.dev}/include:${xorg.libXcursor.dev}/include:${xorg.libXi.dev}/include:${xorg.libXinerama.dev}/include:${xorg.libXrandr.dev}/include:${xorg.libXxf86vm.dev}/include:${xorg.libXext.dev}/include \
      --prefix LD_LIBRARY_PATH : ${stdenv.lib.makeLibraryPath [
        xorg.libX11
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXrandr
        xorg.libXxf86vm
        xorg.libXext
      ]}
  '';

  postFixup = ''
    addOpenGLRunpath $out/bin/hover
  '';
}
