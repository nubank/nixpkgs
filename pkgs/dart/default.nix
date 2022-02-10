{ unstable, fetchurl }:

let
  version = "2.15.1";
  base = "https://storage.googleapis.com/dart-archive/channels";
  x86_64 = "x64";
  i686 = "ia32";
  aarch64 = "arm64";

  sources = {
    "${version}-x86_64-darwin" = fetchurl {
      url = "${base}/stable/release/${version}/sdk/dartsdk-macos-${x86_64}-release.zip";
      sha256 = "sha256-s6bkwh2m5KdRr/WxWXwItO9YaDpp/HI3xjnS2UHmN+I=";
    };
    "${version}-x86_64-linux" = fetchurl {
      url = "${base}/stable/release/${version}/sdk/dartsdk-linux-${x86_64}-release.zip";
      sha256 = "sha256-D0XcqlO0CQtpsne4heqaTLOkFYnJEZET4bl4rVXOM18=";
    };
    "${version}-i686-linux" = fetchurl {
      url = "${base}/stable/release/${version}/sdk/dartsdk-linux-${i686}-release.zip";
      sha256 = "sha256-SRq5TtxS+bwCqVxa0U2Zhn8J1Wtm4Onq+3uQS+951sw=";
    };
    "${version}-aarch64-linux" = fetchurl {
      url = "${base}/stable/release/${version}/sdk/dartsdk-linux-${aarch64}-release.zip";
      sha256 = "sha256-iDbClCNDUsxT6K6koc4EQuu7dppTbOfzCVedpQIKI5U=";
    };
  };
in unstable.dart.override {
  inherit version sources;
}
