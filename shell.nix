{ pkgs ? import <nixpkgs> {
    overlays = [ (import ./default.nix) ];
  }
}:

with pkgs;
pkgs.mkShell {
  buildInputs = [
    nubank.dart # Input here your derivation to build
  ];
}
