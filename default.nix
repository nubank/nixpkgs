self: super:
let
  pkgs = super.pkgs;
  callPackage = super.lib.callPackageWith super;
in
{
  nubank = rec {
    dart = callPackage ./pkgs/dart {};
    flutter = callPackage ./pkgs/flutter {};
    flutter-patch = callPackage ./pkgs/flutter-patch {};
    all-tools = cli-tools ++ clojure-tools ++ desktop-tools;
    cli-tools = with pkgs; [
      awscli
      fzf
      gettext
      jq
      kubectl
      nodejs-10_x
      nss
      nssTools
      openfortivpn
      openssl
      python37Full
      # TODO: ruby is installed by Ansible, but I never saw it used in Nubank
      # ruby
    ];
    clojure-tools = with pkgs; [
      apacheKafka
      clj-kondo
      clojure
      clojure-lsp
      leiningen
    ];
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
