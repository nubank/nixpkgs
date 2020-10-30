{ pkgs }:

let
  mkDart = opts: pkgs.callPackage (import ./dart.nix opts) {};
in
mkDart {
  channel = "stable";
  version = "2.10.0";
  sha256Hash = "0dncmsfbwcn3ygflhp83i6z4bvc02fbpaq1vzdzw8xdk3sbynchb";
}
