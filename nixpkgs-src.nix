{ lib, system, ... }:

import (builtins.fetchTarball {
  url = "https://github.com/nixos/nixpkgs/archive/f5daa8ab31fb910712b3e1e71ae46818bc9e33b3.tar.gz";
  # Use fakeSha256 to generate a new sha256 when updating, i.e.:
  # sha256 = lib.fakeSha256;
  sha256 = "0sa96nmbs37fix7xxxzj3dmryi515arnzicfg71qhkp45gn44dzq";
}) {
  config = { allowUnfree = true; };
  inherit system;
}
