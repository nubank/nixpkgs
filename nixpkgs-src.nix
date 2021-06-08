{ stdenv, ... }:

import (builtins.fetchTarball {
  url = "https://github.com/nixos/nixpkgs/archive/12e7af1cfb3ab5bbbbd1d213a0b17c11ce9d3f2f.tar.gz";
  sha256 = "0xkbvl1gqm1s5s2cfd47bbhd0hm3gws1f2n0n2gnsm8grv60wsx1";
}) {
  config = { allowUnfree = true; };
  system = stdenv.system;
}
