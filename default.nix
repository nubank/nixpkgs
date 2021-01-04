self: super:
let
  pkgs = super.pkgs;
  callPackage = super.lib.callPackageWith super;
  nodejsNubank = pkgs.nodejs-10_x;
  unstable = import (builtins.fetchTarball {
    url = "https://github.com/nixos/nixpkgs/tarball/7002108e07d5140759ff0d7d2eb4045e619b79d6";
    # Use fakeSha256 to generate a new sha256 when updating, i.e.:
    # sha256 = super.stdenv.lib.fakeSha256;
    sha256 = "1izlzaz2nq7pc64k638s6gfqhvxs8snff9ab3hi93k8csm154z84";
  }) {};
in
{
  nubank = rec {
    dart = callPackage ./pkgs/dart {};

    flutter = callPackage ./pkgs/flutter {
      flutterPackages = unstable.flutterPackages;
      dart = dart;
    };

    flutter-patch = callPackage ./pkgs/flutter-patch {};

    all-tools = cli-tools ++ clojure-tools ++ jupyter-tools;

    cli-tools = with pkgs; [
      awscli
      fzf
      gettext
      jq
      kubectl
      minikube
      nodejsNubank
      nss
      nssTools
      openssl
      python37Full
      unstable.openfortivpn
      unstable.tektoncd-cli
      # TODO: ruby is installed by Ansible, but I never saw it used in Nubank
      # ruby
      (yarn.override ({ nodejs = nodejsNubank; }))
    ];

    clojure-tools = with pkgs; [
      # TODO: graalvm build is failing on master and this triggers a long build
      # clj-kondo
      clojure
      clojure-lsp
      leiningen
    ];

    jupyter-tools = with pkgs; [
      jupyter
      python37Packages.jupyter_core
    ];

    # Those are proprietary tools that are better backported from unstable,
    # so don't include them by default
    desktop-tools = with pkgs; [
      slack
      zoom-us
    ];

    hover = unstable.hover.override {
      inherit (unstable);
      flutter = flutter;
    };
  };
}
