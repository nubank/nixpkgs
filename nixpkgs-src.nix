{ stdenv, ... }:

import (builtins.fetchTarball {
  url = "https://github.com/nixos/nixpkgs/archive/02d88b1ff1326ca080d9d1984f2bb64ce95c22db.tar.gz";
  sha256 = "1paa8fbxi7kn7803f5h3vvhkbqz9f35iwmb4l38vj4z73i2zxsrc";
}) {
  config = { allowUnfree = true; };
  system = stdenv.system;
}