{ lib, stdenv, ... }:

import (builtins.fetchTarball {
  url = "https://github.com/nixos/nixpkgs/archive/32f7980afb5e33f1e078a51e715b9f102f396a69.tar.gz";
  # Use fakeSha256 to generate a new sha256 when updating, i.e.:
  # sha256 = lib.fakeSha256;
  sha256 = "02k9xnkrcmkr21b8pycmf1rbbnzh2x5i2wj9wmlghijfvpjqdn27";
}) {
  config = { allowUnfree = true; };
  system = stdenv.system;
}
