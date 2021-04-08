{ flutterPackages, fetchurl, dart }:

let
  version = "2.0.3";
  channel = "stable";
  filename = "flutter_linux_${version}-${channel}.tar.xz";
in flutterPackages.mkFlutter rec {
  inherit dart version;
  pname = "flutter";
  src = fetchurl {
    url = "https://storage.googleapis.com/flutter_infra/releases/${channel}/linux/${filename}";
    sha256 = "14a63cpkp78rgymmlrppds69jsrdarg33dr43nb7s61r0xfh9icm";
  };
  patches = [
    ./disable-auto-update.patch
    ./move-cache.patch
  ];
}
