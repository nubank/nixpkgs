{ flutterPackages, fetchurl, dart }:

let
  version = "2.8.1";
  channel = "stable";
  filename = "flutter_linux_${version}-${channel}.tar.xz";
in flutterPackages.mkFlutter rec {
  inherit dart version;
  pname = "flutter";
  src = fetchurl {
    url = "https://storage.googleapis.com/flutter_infra_release/releases/${channel}/linux/${filename}";
    sha256 = "sha256-R+zcxUgcUaj7Mj8VT4BEyzCdVfqGFKl8ibx8COQ6vgE=";
  };
  patches = [
    ./disable-auto-update.patch
    ./move-cache.patch
  ];
}
