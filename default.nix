self: super:
let
  unstable = import (builtins.fetchTarball {
    # When bumping, use the last commit from https://github.com/NixOS/nixpkgs/tree/nixpkgs-unstable
    # So we can use Hydra cache when possible
    url = "https://github.com/nixos/nixpkgs/archive/4c9a74aa459dc525fcfdfb3019b234f68de66c8a.tar.gz";
    # Use fakeSha256 to generate a new sha256 when updating, i.e.:
    # sha256 = super.stdenv.lib.fakeSha256;
    sha256 = "1wl1q3lqgn3lx3chil59l06pimh9by0bx16h9rk6nfmk6shhwrbw";
  }) {};
  callPackage = unstable.pkgs.callPackage;
in
{
  nubank = rec {
    # Custom packages
    dart = unstable.dart;

    flutter = callPackage ./pkgs/flutter {
      inherit dart;
    };

    flutter-patch = callPackage ./pkgs/flutter-patch {};

    hover = unstable.hover.override { inherit flutter; };

    nodejs = unstable.nodejs-10_x;

    yarn = (unstable.yarn.override {
      inherit nodejs;
    });

    leiningen = (unstable.leiningen.override {
      jdk = unstable.openjdk8;
    });

    # Meta packages
    all-tools = cli-tools ++ clojure-tools ++ jupyter-tools;

    cli-tools = with unstable; [
      awscli
      circleci-cli
      fzf
      gettext
      github-cli
      jq
      kubectl
      minikube
      nodejs
      nss
      nssTools
      openfortivpn
      openssl
      python37Full
      sassc
      tektoncd-cli
      yarn
      # TODO: ruby is installed by Ansible, but I never saw it used in Nubank
      # ruby
    ];

    clojure-tools = with unstable; [
      babashka
      clj-kondo
      clojure
      clojure-lsp
      leiningen
      lumo
    ];

    jupyter-tools = with unstable; [
      jupyter
      python37Packages.jupyter_core
    ];

    # Some Nubankers prefer custom clients, so don't include this set in all-tools
    desktop-tools = with unstable; [
      slack
      zoom-us
    ];
  };
}
