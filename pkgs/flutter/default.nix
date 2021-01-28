{ flutterPackages, fetchurl, dart }:

let
  version = "1.22.5";
  channel = "stable";
  filename = "flutter_linux_${version}-${channel}.tar.xz";
in flutterPackages.mkFlutter rec {
  inherit dart version;
  pname = "flutter";
  src = fetchurl {
    url = "https://storage.googleapis.com/flutter_infra/releases/${channel}/linux/${filename}";
    sha256 = "1dv5kczcj9npf7xxlanmpc9ijnxa3ap46521cxn14c0i3y9295ja";
  };
  depsSha256 = "0d7vhk6axgqajy2d9ia9lc6awcnz6cc3n04r7hnh7bx4hb0jv0l1";
  patches = [
    ./disable-auto-update.patch
    ./move-cache.patch
  ];
}
