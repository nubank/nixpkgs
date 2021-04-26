{ lib, stdenv, ... }:

import (builtins.fetchTarball {
  url = "https://github.com/nixos/nixpkgs/archive/64be38f31fa76963ec31d361f0b797f0cca9d31f.tar.gz";
  # Use fakeSha256 to generate a new sha256 when updating, i.e.:
  # sha256 = lib.fakeSha256;
  sha256 = "11bzji77s1zkww0qfkpqp5rd6np1y7c3syp4x3627w330ap94k8x";
}) {
  config = { allowUnfree = true; };
  system = stdenv.system;
}
