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
    nubank.flutter-patch
    nubank.hover
  ] ++ nubank.all-tools;
}
