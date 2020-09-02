{ pkgs }:

let
  mkDart = opts: pkgs.callPackage (import ./dart.nix opts) {};
in
mkDart {
  channel = "stable";
  version = "2.9.1";
  sha256Hash = "1v8fisjp948r0xp9zakiiz6j0flpnzin4jgl1blingif902j22cf";
}
