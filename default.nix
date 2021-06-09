final: prev:
let
  # TODO: Once Flakes is stable we should manage this with flake.lock instead
  unstable = import ./nixpkgs-src.nix { inherit (prev) lib stdenv; };

  inherit (unstable.pkgs) callPackage;

  clojure-lsp = with final; final.clojure-lsp.overrideAttrs (oldAttrs: rec {
    pname = "clojure-lsp";
    version = "2021.06.01-16.19.44";

    src = fetchFromGitHub {
      owner = pname;
      repo = pname;
      rev = version;
      sha256 = "sha256-dACvjm+uEVWotoeYhA4gCenKeprpF2dI0PGNRAVALao=";
    };

    jar = fetchurl {
      url = "https://github.com/clojure-lsp/clojure-lsp/releases/download/${version}/clojure-lsp.jar";
      sha256 = "sha256-V12rSYv/Yu12ZpLSROd+4pyGiEGRfJ7lmRqCeikcQ5Q=";
    };

    CLOJURE_LSP_JAR = jar;

    # TODO: tests are broken in this release
    doCheck = false;
  });

  dart = unstable.dart;

  flutter = callPackage ./pkgs/flutter { inherit (final.nubank) dart; };

  flutter-patch = callPackage ./pkgs/flutter-patch {};

  hover = unstable.hover.override { inherit (final.nubank) flutter; };

  nodejs = unstable.nodejs-10_x;

  yarn = (unstable.yarn.override { inherit (final.nubank) nodejs; });

  leiningen = (unstable.leiningen.override { jdk = unstable.openjdk11; });
in
{
  nubank = {
    # Custom packages
    inherit dart flutter flutter-patch hover nodejs yarn leiningen;

    # Meta packages
    all-tools = with final.nubank; cli-tools ++ clojure-tools ++ jupyter-tools;

    cli-tools = with unstable; [
      awscli
      aws-iam-authenticator
      circleci-cli
      fzf
      gettext
      github-cli
      jq
      kubectl
      minikube
      nodejs
      openfortivpn
      openssl
      python38Full
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

    jupyter-tools = with unstable; [ jupyter python38Packages.jupyter_core ];

    # Some Nubankers prefer custom clients, so don't include this set in all-tools
    desktop-tools = with unstable; [ slack zoom-us ];
  };
}
