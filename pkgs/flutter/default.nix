{ flutterPackages, dart }:

let
  # Avoid infinite recursion here
  myDart = dart;
in flutterPackages.mkFlutter rec {
  pname = "flutter";
  channel = "stable";
  version = "1.22.4";
  filename = "flutter_linux_${version}-${channel}.tar.xz";
  sha256Hash = "0qalgav9drqddcj8lfvl9ddf3325n953pvkmgha47lslg9sa88zw";
  patches = [
    ./disable-auto-update.patch
    ./move-cache.patch
  ];
  dart = myDart;
}
