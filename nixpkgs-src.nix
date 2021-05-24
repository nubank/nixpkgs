{ stdenv, ... }:

import (builtins.fetchTarball {
  url = "https://github.com/nixos/nixpkgs/archive/efee454783c5c14ae78687439077c1d3f0544d97.tar.gz";
  sha256 = "1qk4g8rav2mkbd6y2zr1pi3pxs4rwlkpr8xk51m0p26khprxvjaf";
}) {
  config = { allowUnfree = true; };
  system = stdenv.system;
}
