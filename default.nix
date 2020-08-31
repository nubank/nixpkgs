self: super:
let
  callPackage = super.lib.callPackageWith super;
in {
  nubank = {
    dart = callPackage ./pkgs/dart {};
    flutter = callPackage ./pkgs/flutter {};
    hover = callPackage ./pkgs/hover {
      inherit (super.xorg);
    };
    hover-nix = callPackage ./pkgs/hover-nix {
      inherit (super.xorg);
    };
  };
}
