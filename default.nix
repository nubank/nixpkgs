final: prev:
let
  # TODO: Once Flakes is stable we should manage this with flake.lock instead
  unstable = import ./nixpkgs-src.nix {
    inherit (prev) lib stdenv;
  };

  inherit (unstable.pkgs) callPackage;
in {
  nubank = rec {
    # Custom packages
    dart = unstable.dart;

    flutter = callPackage ./pkgs/flutter { inherit dart; };

    flutter-patch = callPackage ./pkgs/flutter-patch { };

    hover = unstable.hover.override { inherit flutter; };

    nodejs = unstable.nodejs-10_x;

    yarn = (unstable.yarn.override { inherit nodejs; });

    leiningen = (unstable.leiningen.override { jdk = unstable.openjdk8; });

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

    jupyter-tools = with unstable; [ jupyter python37Packages.jupyter_core ];

    # Some Nubankers prefer custom clients, so don't include this set in all-tools
    desktop-tools = with unstable; [ slack zoom-us ];
  };
}
