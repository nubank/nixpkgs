{ pkgs }:

let
  mkFlutter = opts: pkgs.callPackage (import ./flutter.nix opts) {};
in
mkFlutter rec {
  pname = "flutter";
  channel = "stable";
  version = "1.20.2";
  filename = "flutter_linux_${version}-${channel}.tar.xz";
  sha256Hash = "12j1p3220319411lxbrqfq297fvzjyha1sbscmjpbqc4c4sssxyr";
  patches = [
    ./disable-auto-update.patch
    ./move-cache.patch
  ];
}
