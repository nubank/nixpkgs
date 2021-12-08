{ unstable, fetchurl }:

let
  version = "2.13.1";
  base = "https://storage.googleapis.com/dart-archive/channels";
  x86_64 = "x64";
  i686 = "ia32";
  aarch64 = "arm64";

  sources = {
    "${version}-x86_64-darwin" = fetchurl {
      url = "${base}/stable/release/${version}/sdk/dartsdk-macos-${x86_64}-release.zip";
      sha256 = "0kb6r2rmp5d0shvgyy37fmykbgww8qaj4f8k79rmqfv5lwa3izya";
    };
    "${version}-x86_64-linux" = fetchurl {
      url = "${base}/stable/release/${version}/sdk/dartsdk-linux-${x86_64}-release.zip";
      sha256 = "0zq8wngyrw01wjc5s6w1vz2jndms09ifiymjjixxby9k41mr6jrq";
    };
    "${version}-i686-linux" = fetchurl {
      url = "${base}/stable/release/${version}/sdk/dartsdk-linux-${i686}-release.zip";
      sha256 = "0zv4q8xv2i08a6izpyhhnil75qhs40m5mgyvjqjsswqkwqdf7lkj";
    };
    "${version}-aarch64-linux" = fetchurl {
      url = "${base}/stable/release/${version}/sdk/dartsdk-linux-${aarch64}-release.zip";
      sha256 = "0bb9jdmg5p608jmmiqibp13ydiw9avgysxlmljvgsl7wl93j6rgc";
    };
  };
in unstable.dart.override {
  inherit version sources;
}
