{ lib, stdenv, ... }:

import (builtins.fetchTarball {
  url = "https://github.com/nixos/nixpkgs/archive/c039c62aae24899860719c8a669ac94ec5daa99d.tar.gz";
  # Use fakeSha256 to generate a new sha256 when updating, i.e.:
  # sha256 = lib.fakeSha256;
  sha256 = "0gsid8wadkhy9yyajycg22csxix7m9fjl8qdpdqzm53la1nhwj26";
}) {
  config = { allowUnfree = true; };
  system = stdenv.system;
}
