{ flutterPackages, fetchurl, dart }:

let
  version = "1.22.4";
  channel = "stable";
  filename = "flutter_linux_${version}-${channel}.tar.xz";
in flutterPackages.mkFlutter rec {
  inherit dart version;
  pname = "flutter";
  src = fetchurl {
    url = "https://storage.googleapis.com/flutter_infra/releases/${channel}/linux/${filename}";
    sha256 = "0qalgav9drqddcj8lfvl9ddf3325n953pvkmgha47lslg9sa88zw";
  };
  patches = [
    ./disable-auto-update.patch
    ./move-cache.patch
  ];
}
