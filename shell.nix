{ pkgs ? import <nixpkgs> {
    overlays = [ (import ./default.nix) ];
  }
}:

with pkgs;
pkgs.mkShell {
  buildInputs = [
    # You can comment some derivations here to test only one package
    nubank.dart
    nubank.flutter
    nubank.hover
    # TODO: needs to be add to nubank.hover
    pkgs.go
  ];
}
