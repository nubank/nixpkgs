final: prev:
let
  unstable = import ./nixpkgs-src.nix {
    inherit (prev) lib;
    system = prev.stdenv.system;
  };

  inherit (unstable.pkgs) callPackage;

  cortex = callPackage ./pkgs/cortex { inherit (unstable); };

  dart = callPackage ./pkgs/dart { inherit unstable; };

  flutter = callPackage ./pkgs/flutter { inherit (final.nubank) dart; };

  flutter-patch = callPackage ./pkgs/flutter-patch {};

  hover = unstable.hover.override { inherit (final.nubank) flutter; };

  nodejs = unstable.nodejs-14_x;

  yarn = (unstable.yarn.override { inherit (final.nubank) nodejs; });

  leiningen = (unstable.leiningen.override { jdk = unstable.openjdk11; });

  terraform = (unstable.mkTerraform {
    version = "1.0.2";
    sha256 = "sha256-KmSkHJ5RB2cP4z/IT/p+LHm658soM0IS0TPYKxU02z4=";
    vendorSha256 = "sha256-s5HFBPWv7OEvgMBkAVZNivk6tD1T3QjUDqsIU9TPLmA=";
  });
in
{
  nubank = {
    # Custom packages
    inherit cortex dart flutter flutter-patch hover nodejs yarn leiningen;

    # Meta packages
    all-tools = with final.nubank; cli-tools ++ clojure-tools ++ jupyter-tools;

    cli-tools = with unstable; [
      aws-iam-authenticator
      awscli
      circleci-cli
      fzf
      gettext
      github-cli
      jq
      kubectl
      minikube
      nodejs
      nssTools
      openfortivpn
      openssl
      python38Full
      sassc
      tektoncd-cli
      terraform
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
