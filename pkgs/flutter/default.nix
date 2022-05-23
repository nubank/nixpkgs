{ flutterPackages, fetchurl, dart }:

let
  version = "2.2.1";
  channel = "stable";
  filename = "flutter_linux_${version}-${channel}.tar.xz";
in flutterPackages.mkFlutter rec {
  inherit dart version;
  pname = "flutter";
  src = fetchurl {
    url = "https://storage.googleapis.com/flutter_infra/releases/${channel}/linux/${filename}";
    sha256 = "009pwk2casz10gibgjpz08102wxmkq9iq3994b3c2q342g6526g0";
  };
  patches = [
    ./disable-auto-update.patch
    ./move-cache.patch
  ];
}
