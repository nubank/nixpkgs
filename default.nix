self: super:
let
  pkgs = super.pkgs;
  callPackage = super.lib.callPackageWith super;
in
{
  nubank = rec {
    dart = callPackage ./pkgs/dart {};
    flutter = callPackage ./pkgs/flutter {};
    hover = callPackage ./pkgs/hover {
      inherit (super.xorg);
      # TODO: go_1_14 seems broken in 20.03
      go = pkgs.go_1_13;
      flutter = flutter;
    };
  };
}
