{ pkgs ? import <nixpkgs> {
    overlays = [ (import ./default.nix) ];
  }
}:

with pkgs;
pkgs.mkShell {
  buildInputs = [
    nubank.hover-nix # Input here your derivation to build
  ];
}
