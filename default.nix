self: super:
let
  mkFlutter = opts: super.pkgs.callPackage (import ./flutter.nix opts) { };
  getPatches = dir:
    let files = builtins.attrNames (builtins.readDir dir);
    in map (f: dir + ("/" + f)) files;
in {
  flutter-nubank = mkFlutter rec {
    pname = "flutter";
    channel = "stable";
    version = "1.20.2";
    filename = "flutter_linux_${version}-${channel}.tar.xz";
    sha256Hash = "12j1p3220319411lxbrqfq297fvzjyha1sbscmjpbqc4c4sssxyr";
    patches = getPatches ./patches/flutter;
  };
}
