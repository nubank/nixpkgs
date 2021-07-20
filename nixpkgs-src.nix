{ stdenv, ... }:

import (builtins.fetchTarball {
  url = "https://github.com/nixos/nixpkgs/archive/1441fa74d213d7cc120d9d7d49e540c1fc59bc58.tar.gz";
  sha256 = "152qb7ch0r4bidik33zd0a9wl0929zr0dqs5l5ksm7vh3assc7sc";
}) {
  config = { allowUnfree = true; };
  system = stdenv.system;
}