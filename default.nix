self: super:
let
  unstable = import (builtins.fetchTarball {
    # When bumping, use the last commit from https://github.com/NixOS/nixpkgs/tree/nixpkgs-unstable
    # So we can use Hydra cache when possible
    url = "https://github.com/nixos/nixpkgs/archive/2080afd039999a58d60596d04cefb32ef5fcc2a2.tar.gz";
    # Use fakeSha256 to generate a new sha256 when updating, i.e.:
    # sha256 = super.stdenv.lib.fakeSha256;
    sha256 = "0i677swvj8fxfwg3jibd0xl33rn0rq0adnniim8jnp384whnh8ry";
  }) {};
  # TODO: Remove when merged: https://github.com/NixOS/nixpkgs/pull/108328
  clojureLspBump = import (builtins.fetchTarball {
    url = "https://github.com/ericdallo/nixpkgs/archive/b12b7f96ad7ccdf057cbcd5d34b57a854c601709.tar.gz";
    sha256 = "0g4fjs7ydpw4r4a2fmccr82pifc1vwvca590zr5bjnmalfwrbhvp";
  }) {};
  callPackage = unstable.pkgs.callPackage;
in
{
  nubank = rec {
    # Custom packages
    dart = callPackage ./pkgs/dart {};

    flutter = callPackage ./pkgs/flutter {
      dart = dart;
    };

    flutter-patch = callPackage ./pkgs/flutter-patch {};

    nodejs = unstable.nodejs-10_x;

    yarn = (unstable.yarn.override {
      nodejs = nodejs;
    });

    leiningen = (unstable.leiningen.override {
      jdk = unstable.openjdk8;
    });

    hover = unstable.hover.override {
      inherit (unstable);
      flutter = flutter;
    };

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
      clojureLspBump.clojure-lsp
      leiningen
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
