{ system ? builtins.currentSystem, ... }:

import (builtins.fetchTarball {
  url = "https://github.com/nixos/nixpkgs/archive/070c8d83414ce38427ba04168676831aa26fda76.tar.gz";
  sha256 = "0vwm2m6x98br09zx7ijhq5iz68wnrhv430nza5bzbqsnapsq3b1c";
}) {
  inherit system;
  config = { allowUnfree = true; };
}