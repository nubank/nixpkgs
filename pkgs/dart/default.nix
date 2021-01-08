{ pkgs }:

let
  mkDart = opts: pkgs.callPackage (import ./dart.nix opts) {};
in
mkDart {
  channel = "stable";
  version = "2.10.4";
  sha256Hash = "0pjqj2bsliq13q8b2mk2v07w4vzjqcmr984ygnwv5kx0dp5md7vq";
}
