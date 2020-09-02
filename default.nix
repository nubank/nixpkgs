self: super:
let
  pkgs = super.pkgs;
  callPackage = super.lib.callPackageWith super;
  nodejsNubank = pkgs.nodejs-10_x;
in
{
  nubank = rec {
    dart = callPackage ./pkgs/dart {};

    flutter = callPackage ./pkgs/flutter {};

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
      openfortivpn
      openssl
      python37Full
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

    hover = callPackage ./pkgs/hover {
      inherit (super.xorg);
      go = pkgs.go;
      flutter = flutter;
    };
  };
}
