{ lib, stdenv, ... }:

import (builtins.fetchTarball {
  url = "https://github.com/nixos/nixpkgs/archive/a5f6343808293cb77a2f6f735bce0442d13a0999.tar.gz";
  # Use fakeSha256 to generate a new sha256 when updating, i.e.:
  # sha256 = lib.fakeSha256;
  sha256 = "0v32ni5yq5v2m8jq1xnqhn4lc7j4whlscpv54rrwdbqqf5szjrwi";
}) {
  config = { allowUnfree = true; };
  system = stdenv.system;
}
