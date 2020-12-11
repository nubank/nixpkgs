{ flutterPackages, dart }:

let
  # Avoid infinite recursion here
  myDart = dart;
in flutterPackages.mkFlutter rec {
  pname = "flutter";
  channel = "stable";
  version = "1.22.2";
  filename = "flutter_linux_${version}-${channel}.tar.xz";
  sha256Hash = "0q9p8b251s3agjxpc97pjrjvfgxn9qyfswb1g7kq8id3hpljrm11";
  patches = [
    ./disable-auto-update.patch
    ./move-cache.patch
  ];
  dart = myDart;
}
