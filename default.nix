self: super:
let
  mkDart = opts: super.pkgs.callPackage (import ./dart.nix opts) { };
  mkFlutter = opts: super.pkgs.callPackage (import ./flutter.nix opts) { };
  hover = opts: super.pkgs.callPackage (import ./hover.nix opts) { };
  getPatches = dir:
    let files = builtins.attrNames (builtins.readDir dir);
    in map (f: dir + ("/" + f)) files;
in {
  nubank = {
    dart = mkDart {
      channel = "stable";
      version = "2.9.1";
      sha256Hash = "1v8fisjp948r0xp9zakiiz6j0flpnzin4jgl1blingif902j22cf";
    };
    flutter = mkFlutter rec {
      pname = "flutter";
      channel = "stable";
      version = "1.20.2";
      filename = "flutter_linux_${version}-${channel}.tar.xz";
      sha256Hash = "12j1p3220319411lxbrqfq297fvzjyha1sbscmjpbqc4c4sssxyr";
      patches = getPatches ./patches/flutter;
    };
    hover = hover;
  };
}
