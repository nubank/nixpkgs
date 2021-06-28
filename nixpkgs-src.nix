{ stdenv, ... }:

import (builtins.fetchTarball {
  url = "https://github.com/nixos/nixpkgs/archive/dbf5cd2d90cbf8b281c1938632b431d1e61d3249.tar.gz";
  sha256 = "0ak60qwizcadqx57k4609ifzx18bnz0vdlm75h5i0pd7fp3b2r40";
}) {
  config = { allowUnfree = true; };
  system = stdenv.system;
}
