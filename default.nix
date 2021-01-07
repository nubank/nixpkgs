self: super:
let
  unstable = import (builtins.fetchTarball {
    # When bumping, use the last commit from https://github.com/NixOS/nixpkgs/tree/nixpkgs-unstable
    # So we can use Hydra cache when possible
    url = "https://github.com/nixos/nixpkgs/archive/479867700baa7ced259c979a0f724915c4d46d12.tar.gz";
    # Use fakeSha256 to generate a new sha256 when updating, i.e.:
    # sha256 = super.stdenv.lib.fakeSha256;
    sha256 = "0dwci1sw81qn0b0cnksw3qf9lfhyz0rfvs14l3yh9iq6qfcs2aq7";
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
      clojure-lsp
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
