{ pkgs ? import ../nixpkgs-src.nix { } }:

with pkgs;

mkShell {
  buildInputs = [
    babashka
    git
    nix
  ];
}
