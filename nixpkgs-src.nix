{ stdenv, ... }:

import (builtins.fetchTarball {
  url = "https://github.com/nixos/nixpkgs/archive/ebc72941f0d47625a03bac63f4b0ae55a356a849.tar.gz";
  sha256 = "0q4r33kzhsdf624c8cxwip8xnhn3gs2i36jgw2q4cdmsjmyw8z5n";
}) {
  config = { allowUnfree = true; };
  system = stdenv.system;
}
